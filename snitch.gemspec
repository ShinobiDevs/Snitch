$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "snitch/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "snitch"
  s.version     = Snitch::VERSION
  s.authors     = ["elad@shinobidevs.com", "miki@shinobidevs.com", "caduri@shinobidevs.com"]
  s.email       = ["elad@shinobidevs.com"]
  s.homepage    = "TODO"
  s.summary     = "Reporter class"
  s.description = "Reporting events in the system"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.0.0"
  s.add_dependency 'mongoid'
  s.add_dependency 'bson_ext'
  s.add_dependency 'sidekiq'
end
