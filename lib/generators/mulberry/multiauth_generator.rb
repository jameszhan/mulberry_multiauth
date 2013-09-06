module Mulberry
  class MultiauthGenerator < Rails::Generators::Base
    desc "Copy Devise Config file and OmniauthConfig"
    source_root File.expand_path('../templates', __FILE__)    


    def setup_gemfile
      gem 'omniauth-taobao'
      gem 'omniauth-qq-connect'
      gem 'omniauth-github'
      gem 'omniauth-weibo', git: 'git://github.com/jameszhan/omniauth-weibo.git'
    end
    
    def copy_initializers
      template 'devise.rb', 'config/initializers/devise.rb', skip: true
    end
    
    def copy_multiauth_config
      template 'multiauth_config.yml', 'config/multiauth_config.yml', skip: true
    end

  end
end