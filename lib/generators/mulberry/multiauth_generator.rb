module Mulberry
  class MultiauthGenerator < Rails::Generators::Base
    include Rails::Generators::Migration
        
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
      template 'multiauth_config.yml', 'config/multiauth_config.yml', skip: true, force: false
    end
    
    def create_migration_file
      if self.class.orm_has_migration?
        migration_template 'db/migrate/devise_create_users.rb'
        sleep 1
        migration_template 'db/migrate/create_authentications.rb'
        sleep 1
        migration_template 'db/migrate/add_fields_to_users.rb'
      end
    end
    
    class << self
      def orm_has_migration?
        Rails::Generators.options[:rails][:orm] == :active_record
      end

      def next_migration_number(dirname)
        if ActiveRecord::Base.timestamped_migrations
          migration_number = Time.now.utc.strftime("%Y%m%d%H%M%S")
        else
          "%.3d" % (current_migration_number(dirname) + 1)
        end
      end
    end

  end
end