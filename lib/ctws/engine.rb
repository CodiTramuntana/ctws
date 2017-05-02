module Ctws
  class Engine < ::Rails::Engine
    isolate_namespace Ctws
    config.generators.api_only = true
    
    config.generators do |g|
      g.test_framework :rspec, :fixture => false
      g.fixture_replacement :factory_girl_rails, :dir => 'spec/factories'
      g.assets false
      g.helper false
    end
  end
end
