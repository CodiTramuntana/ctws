module Ctws
  class Engine < ::Rails::Engine
    require "http_accept_language"

    engine_name "ctws"
    isolate_namespace Ctws
    config.generators.api_only = true

    config.generators do |g|
      g.test_framework :rspec, :fixture => false
      g.assets false
      g.helper false
    end
  end
end
