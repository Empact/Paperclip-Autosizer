class PaperclipAutosizer < ActiveRecord::Base
  self.abstract_class = true

  attr_writer :autosizer_attachment_name, :autosizer_original_file_geometry

private
  def autosizer_attachment
    send(@autosizer_attachment_name)
  end

  def autosize_attached_files
    styles_to_autosize.each_pair do |style, column_for_style|
      send(:"#{column_for_style}=", calculate_size_of_reduced_image(style))
    end
  end

  def styles_to_autosize
    autosizer_attachment.styles.keys.inject({}) do |accumulator, style|
      column_for_style = [@autosizer_attachment_name, style.to_s, "size"].join("_")
      if self.class.column_names.include?(column_for_style)
        accumulator[style] = column_for_style
      end
      accumulator
    end
  end

  def calculate_size_of_reduced_image(style)
    target_width, target_height = autosizer_attachment.styles[style][:geometry].split("x").collect{|x| x.to_f}
    width, height = @autosizer_original_file_geometry.width, @autosizer_original_file_geometry.height
    original_ratio = width.to_f / height.to_f
    if (original_ratio <= 1 && target_height < height)
      width  = original_ratio * target_height
      height = target_height
    elsif (target_width < width)
      width  = target_width
      height = (1 / original_ratio) * target_width
    end
    [width.round, height.round].join("x")
  end
end
