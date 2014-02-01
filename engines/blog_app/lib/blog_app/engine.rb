require "haml"
require "haml-rails"
require "decent_exposure"
require "sass-rails"
require "compass-rails"
require "acts-as-taggable-on"
require "stringex"
require "pygments"
require "kaminari"
require "jquery-rails"
require "backbone-rails"
require "bootstrap-sass"

module BlogApp
  class Engine < ::Rails::Engine
    isolate_namespace BlogApp

    ActsAsTaggableOn::Tagging.table_name = "blog_app_taggings"
    ActsAsTaggableOn::Tag.table_name = "blog_app_tags"

    config.generators do |g|
      g.test_framework      :rspec,        fixture: false
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
    end

    initializer :append_migrations do |app|
      unless app.root.to_s.match root.to_s
        config.paths["db/migrate"].expanded.each do |expanded_path|
          app.config.paths["db/migrate"] << expanded_path
        end
      end
    end
  end
end
