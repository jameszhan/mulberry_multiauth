$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "mulberry_multiauth/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "mulberry_multiauth"
  s.version     = MulberryMultiauth::VERSION
  s.authors     = ["James Zhan"]
  s.email       = ["zhiqiangzhan@gmail.com"]
  s.homepage    = "https://github.com/jameszhan/mulberry_multiauth"
  s.summary     = "Multiple authentications with omniauth."
  s.description = "User can bind multiple omniauth."
  
  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]  
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", "~> 4.0.0"

  s.add_dependency 'devise'
  s.add_dependency 'jquery-crop-rails'
  s.add_dependency 'carrierwave'
  s.add_dependency 'rmagick'
  s.add_dependency 'simple_form'
  s.add_dependency 'omniauth'
  s.add_dependency 'bootstrap-sass-rails'
    
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'factory_girl_rails'

  s.add_development_dependency "sqlite3"
end
