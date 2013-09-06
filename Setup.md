##Setup Project

> rails plugin new mulberry_multiauth --skip-test-unit --full

##RSpec Configure

###Rails App (In Gemfile)
~~~ruby
  group :development, :test do 
    gem 'rspec-rails' 
    gem 'factory_girl_rails' 
  end 

  group :test do 
    gem 'faker' 
    gem 'capybara' 
    gem 'guard-rspec' 
    gem 'launchy' 
  end
~~~

* rspec-rails includes RSpec itself in a wrapper to make it play nicely with Rails 3.
* factory_girl_rails replaces Rails’ default fixtures for feeding test data to the test suite with much more preferable factories.
* faker generates names, email addresses, and other placeholders for factories.
* capybara makes it easy to programatically simulate your users’ interactions with your application.
* launchy does one thing, but does it well: It opens your default web browser upon failed integration specs to show you what your application is rendering.
* guard-rspec watches your application and tests and runs specs for you automatically when it detects changes.


####Open config/application.rb and include the following code inside the Application class:

~~~ruby
  config.generators do |g| 
    g.test_framework :rspec, 
      :fixtures => true, 
      :view_specs => false, 
      :helper_specs => false, 
      :routing_specs => false, 
      :controller_specs => true, 
      :request_specs => true 
    g.fixture_replacement :factory_girl, 
      :dir => "spec/factories" 
  end
~~~

###Ruby Gem (In GEM.gemspec)
~~~ruby
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'factory_girl_rails'
  
  s.test_files = Dir["spec/**/*"]
~~~

###Open lib/PROJECT/engine.rb and add the following code to it
~~~ruby
  config.generators do |g|
    g.test_framework      :rspec,        :fixture => false
    g.fixture_replacement :factory_girl, :dir => 'spec/factories'
  end
~~~



###RSpec Install
> rails g rspec:install

###Devise Configure & DB Setup

> rails g devise:install  
  
> rails g devise User 
   
> rails g model authentication user:belongs_to uid:string provider:string access_token:string

> rails g migration add_avatar_to_users avatar:string crop_x:integer crop_y:integer crop_w:integer crop_h:integer

> rails g uploader Avatar

> rails g simple_form:install --bootstrap

> rails g controller users

> rails g migration addNameToUsers


class UploaderGenerator < Rails::Generators::NamedBase
  source_root File.expand_path("../templates", __FILE__)

  def create_uploader_file
    template "uploader.rb", "app/uploaders/#{file_name}_uploader.rb"
  end
end


