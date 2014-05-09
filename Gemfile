source 'https://rubygems.org'

ruby '2.0.0'

gem 'rails', '~> 4.0.0'
gem 'puma'
gem 'jquery-rails'
gem 'haml', '~> 4.0'
gem 'haml-rails'
gem 'high_voltage'
gem 'rails-backbone'
gem 'rack-rewrite', require: false
gem 'pg'
gem 'decent_exposure'
gem 'rack-cors', require: 'rack/cors'
gem 'training_app', path: '../training_app'
gem 'blog_app', path: 'engines/blog_app'

gem 'foundation_rails_helper', github: 'sgruhier/foundation_rails_helper', ref: 'ed5b2903'
gem 'sentry-raven', git: 'https://github.com/getsentry/raven-ruby.git'

gem 'compass-rails', '1.1.0.pre'
gem 'activeadmin',         github: 'gregbell/active_admin'
gem 'pipedrive-ruby',      github: 'GeneralScripting/pipedrive-ruby'

# Gems used only for assets and not required
# in production environments by default.
gem 'coffee-rails', '~> 4.0.0'
gem 'sass-rails',   '~> 4.0.0'
gem 'uglifier', '~> 2.1.0'
gem 'zurb-foundation', '~> 4.0'

group :development, :test do
  gem 'pry'
  gem 'rspec-rails'
  gem 'dotenv-rails'
  gem 'spring'
  gem 'spring-commands-rspec'
end

group :test do
  gem 'poltergeist'
  gem 'factory_girl_rails'
  gem 'timecop'
  gem 'shoulda-matchers'
  gem 'launchy'
  gem 'database_cleaner'
end

group :staging, :production do
  gem 'rails_12factor'
end

group :production do
  gem 'asset_sync'
end

