$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "tracker_jacker/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "tracker_jacker"
  s.version     = TrackerJacker::VERSION
  s.authors     = ["John Gesimondo"]
  s.email       = ["john@jmondo.com"]
  s.homepage    = "https://github.com/HealthyDelivery/tracker_jacker"
  s.summary     = "Track events and ActiveRecord attribute changes"
  s.description = "Track events and ActiveRecord attribute changes in a timeline"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", ">= 5.0.0"

  s.add_development_dependency "sqlite3", ">= 1.3.0"
  s.add_development_dependency "rspec-rails", ">= 3.6.1"
  s.add_development_dependency "appraisal", "~> 1.0"
end
