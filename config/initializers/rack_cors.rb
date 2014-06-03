module Gaslight
  class Application < Rails::Application
    config.middleware.use Rack::Cors do
      allow do
        origins 'localhost:3000', '127.0.0.1:3000', %r{^https?:\/\/([a-z0-9\-]+.)?gaslight.(co|dev)}i
        resource '*',
          headers: :any,
          methods: [:get]
      end
    end
  end
end

