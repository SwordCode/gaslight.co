$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "blog_app/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "blog_app"
  s.version     = BlogApp::VERSION
  s.authors     = ["TODO: Your name"]
  s.email       = ["TODO: Your email"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of BlogApp."
  s.description = "TODO: Description of BlogApp."

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency 'rails', '~> 4.0.0'
  s.add_dependency 'decent_exposure'
  s.add_dependency 'haml', '~> 4.0'
  s.add_dependency 'haml-rails'
  s.add_dependency 'sass-rails', '~> 4.0.0'
  s.add_dependency 'jquery-rails'
  s.add_dependency 'rails-backbone'
  s.add_dependency 'compass-rails', '~> 2.0.alpha.0'
  s.add_dependency 'redcarpet'
  s.add_dependency 'htmlentities'
  s.add_dependency 'acts-as-taggable-on'
  s.add_dependency 'stringex'
  s.add_dependency 'pygments.rb'
  s.add_dependency 'rack-rewrite'
  s.add_dependency 'kaminari'
  s.add_dependency 'engagement'

  s.add_development_dependency 'pg'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'capybara'
  s.add_development_dependency 'poltergeist'
  s.add_development_dependency 'factory_girl_rails'
  s.add_development_dependency 'pry'
  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency 'dotenv-rails'
  s.add_development_dependency 'selenium-webdriver'
end
