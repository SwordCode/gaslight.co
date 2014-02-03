require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module Gaslight
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.i18n.enforce_available_locales = true
    I18n.config.enforce_available_locales = true
    config.exceptions_app = self.routes

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Eastern Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
    config.compass.images_dir = '/app/assets/images'

    config.middleware.insert_before(Rack::Runtime, Rack::Rewrite) do
      r301 %r{.*}, 'http://gaslight.co/coffee', if: Proc.new { |rack_env|
        rack_env['SERVER_NAME'] == 'coffee.gaslightsoftware.com'
      }

      r301 %r{.*}, 'http://training.gaslight.co$&', if: Proc.new { |rack_env|
        rack_env['SERVER_NAME'] == 'training.gaslightsoftware.com'
      }

      r301 %r{.*}, 'http://gaslight.co$&', if: Proc.new { |rack_env|
        rack_env['SERVER_NAME'] =~ /^(www.)?gaslightsoftware.com|www.gaslight.co/
      }

      blog_domains = %w[ blog.gaslightsoftware.com blog.gaslight.co ]

      r301 %r{.*}, 'http://gaslight.co/blog', if: Proc.new { |rack_env|
        blog_domains.include?(rack_env['SERVER_NAME']) &&
          (rack_env['REQUEST_URI'] == '/' || rack_env['REQUEST_URI'].blank?)
      }

      rewrite %r{.*}, '$&', if: Proc.new { |rack_env|
        blog_domains.include?(rack_env['SERVER_NAME'])
      }
    end

    config.middleware.use Rack::Cors do
      allow do
        origins 'localhost:3000','gaslight.co'
        resource '/authors', :headers => :any, :methods => [:get]
      end
    end
  end
end
