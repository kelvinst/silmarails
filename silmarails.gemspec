$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "silmarails/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "silmarails"
  s.version     = Silmarails::VERSION
  s.authors     = ["kelvinst"]
  s.email       = ["kelvin.stinghen@gmail.com"]
  s.homepage    = "https://github.com/kelvinst/silmarails"
  s.summary     = "A complete set of tools for building rails applications"
  s.description = "This gem is a set of generators, templates and helpers to
                    start a brand new rails project without too many code to
                    write. If you need more details, check the project README."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", ">= 4.2"

  s.add_development_dependency "pry", "~> 0.10"
  s.add_development_dependency "rspec", "~> 3.4"
end
