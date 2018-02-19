$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "ctws/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "ctws"
  s.version     = Ctws::VERSION
  s.authors     = ["Agustí B.R."]
  s.email       = ["agusti.br@coditramuntana.com"]
  s.homepage    = "https://github.com/CodiTramuntana/ctws"
  s.summary     = "Rails gem to be used as Webservice base."
  s.description = "Adds a Webservice API to an existing Rails App."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "LICENSE", "Rakefile", "README.md"]

  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", "~> 5.0"
  s.add_dependency "bcrypt", "~> 3.1"
  s.add_dependency "jwt", "~> 2.1"
  s.add_dependency 'http_accept_language', '~> 2.0', '>= 2.0.5'
  # s.add_dependency "rack-cors", require: 'rack/cors'
  # s.add_dependency "rack-attack"

  s.add_development_dependency "sqlite3", "~> 1.3"
  s.add_development_dependency "rspec-rails", "~> 3.6"
  s.add_development_dependency 'factory_girl_rails', "~> 4.8"
  s.add_development_dependency 'shoulda-matchers', "~> 3.1"
  s.add_development_dependency 'faker', "~> 1.8"
  s.add_development_dependency 'database_cleaner', "~> 1.6"
  s.add_development_dependency 'rake', "~> 12.0"
end
