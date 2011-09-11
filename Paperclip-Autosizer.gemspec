# Provide a simple gemspec so you can easily use your
# project in your rails apps through git.
Gem::Specification.new do |s|
  s.name = "Paperclip-Autosizer"
  s.summary = "Insert PaperclipAutosizer summary."
  s.description = "Insert PaperclipAutosizer description."
  s.authors = ['Andrew Eisberg', 'Ben Woosley']
  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]
  s.version = "0.0.1"
end
