$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "acts_as_trackable_event/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "acts_as_trackable_event"
  s.version     = ActsAsTrackableEvent::VERSION
  s.authors     = ["John Gesimondo"]
  s.email       = ["john@jmondo.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of ActsAsTrackableEvent."
  s.description = "TODO: Description of ActsAsTrackableEvent."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 4.2.0"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
end
