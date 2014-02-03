require 'rack/rewrite'

Gaslight::Application.configure do
  config.middleware.insert_before(Rack::Runtime, Rack::Rewrite) do
    current_domain = 'gaslight.co'

    r301 %r{.*}, "http://#{current_domain}/coffee", if: Proc.new { |rack_env|
      rack_env['SERVER_NAME'] == 'coffee.gaslightsoftware.com'
    }

    r301 %r{.*}, "http://training.#{current_domain}$&", if: Proc.new { |rack_env|
      rack_env['SERVER_NAME'] == 'training.gaslightsoftware.com'
    }

    r301 %r{.*}, "http://#{current_domain}$&", scheme: 'http', if: Proc.new { |rack_env|
      rack_env['rack.url_scheme'] == 'http' && rack_env['SERVER_NAME'] =~ /^(www.)?gaslightsoftware.com|www.gaslight.co/
    }

    r301 %r{.*}, "https://#{current_domain}$&", scheme: 'https', if: Proc.new { |rack_env|
      rack_env['rack.url_scheme'] == 'https' && rack_env['SERVER_NAME'] =~ /^(www.)?gaslightsoftware.com|www.gaslight.co/
    }

    blog_domains = %w[ blog.gaslightsoftware.com blog.gaslight.co ]

    r301 %r{.*}, "http://#{current_domain}/blog", if: Proc.new { |rack_env|
      blog_domains.include?(rack_env['SERVER_NAME']) &&
        (rack_env['REQUEST_URI'] == '/' || rack_env['REQUEST_URI'].blank?)
    }

    rewrite %r{.*}, '$&', if: Proc.new { |rack_env|
      blog_domains.include?(rack_env['SERVER_NAME'])
    }
  end
end

