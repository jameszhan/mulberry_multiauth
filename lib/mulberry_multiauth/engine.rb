module MulberryMultiauth
  class Engine < ::Rails::Engine
    
    config.generators do |g|
      g.test_framework      :rspec,        :fixture => false
      g.fixture_replacement :factory_girl, :dir => 'spec/factories'
    end
    
    config.before_configuration do
      require 'devise'
      require 'devise/orm/active_record' 
    end
    
    initializer "multiauth" do |app|

      config_file = Rails.root + "config/multiauth_config.yml"

      if File.exist?(config_file)
        providers = YAML::load(ERB.new(File.read(config_file)).result)
        if providers.blank?
          #raise ArgumentError, "#{config_file} is invalid"
        elsif providers[Rails.env].nil?
          #raise ArgumentError, "cannot find section for #{Rails.env} environment in #{config_file}"
        end

        MulberryMultiauth.providers = providers[Rails.env]
    
        MulberryMultiauth.providers.each do |provider, config|
          puts ">> Setting up #{provider} provider"
          Devise.omniauth provider.underscore.to_sym, config["id"], config["secret"]
        end

      else
        $stderr.puts "Config file doesn't exist: #{config_file}, you can run rails g mulberry:multiauth"
      end
    end
    
  end
end
