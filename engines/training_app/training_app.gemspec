$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "training_app/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "training_app"
  s.version     = TrainingApp::VERSION
  s.authors     = ["Gaslight"]
  s.email       = ["hello@gaslight.co"]
  s.homepage    = "http://gaslight.co"
  s.summary     = "The Gaslight training app!"
  s.description = "Rails engine powering Gaslight training"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", "~> 4.0.0"
  s.add_dependency "eco"
  s.add_dependency "stripe"
  s.add_dependency "decent_exposure"
  s.add_dependency "haml", '~> 4.0'
  s.add_dependency "haml-rails"
  s.add_dependency "sass-rails", "~> 4.0.0"
  s.add_dependency "compass-rails", "1.1.0.pre"
  s.add_dependency "font-awesome-rails"
  s.add_dependency "ember-rails"
  s.add_dependency "ember-source", "~> 1.2.0"
  s.add_dependency "active_model_serializers"
  s.add_dependency "redcarpet"
  s.add_dependency "zurb-foundation", '~> 4.0'
  s.add_dependency "geocoder"
  s.add_dependency "leaflet-rails"

  s.add_development_dependency 'pg'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'capybara'
  s.add_development_dependency 'poltergeist'
  s.add_development_dependency 'factory_girl_rails'
  s.add_development_dependency "shoulda-matchers", "~> 2.4.0"
  s.add_development_dependency "pry"
  s.add_development_dependency "database_cleaner", "1.0.1"
  s.add_development_dependency "dotenv-rails"
  s.add_development_dependency "selenium-webdriver"
end
