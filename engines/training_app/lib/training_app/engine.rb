require "haml"
require "haml-rails"
require "decent_exposure"
require "eco"
require "stripe"
require "sass-rails"
require "compass-rails"
require "font-awesome-rails"
require "ember-rails"
require "zurb-foundation"
require "geocoder"
require "leaflet-rails"

module TrainingApp
  class Engine < ::Rails::Engine
    isolate_namespace TrainingApp

    rake_tasks do
      load File.join(File.dirname(__FILE__), 'rails/railties/training_app_tasks.rake')
    end

    config.generators do |g|
      g.test_framework      :rspec,        fixture: false
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
      g.assets false
      g.helper false
    end

    initializer :append_migrations do |app|
      unless app.root.to_s.match root.to_s
        config.paths["db/migrate"].expanded.each do |expanded_path|
          app.config.paths["db/migrate"] << expanded_path
        end
      end
    end

    config.ember.variant = ENV.fetch('RAILS_ENV', nil) == "production" ? :production : :development
    config.handlebars.templates_root = 'training_app/templates'
  end
end

