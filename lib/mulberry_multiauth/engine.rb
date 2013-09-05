module MulberryMultiauth
  class Engine < ::Rails::Engine
    
    config.generators do |g|
      g.test_framework      :rspec,        :fixture => false
      g.fixture_replacement :factory_girl, :dir => 'spec/factories'
    end
    
    config.before_configuration do
      require 'devise'
    end
    
  end
end
