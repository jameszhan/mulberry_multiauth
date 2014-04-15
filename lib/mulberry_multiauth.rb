require "mulberry_multiauth/engine"
require 'carrierwave'
require 'simple_form'
require 'jquery-crop-rails'

module MulberryMultiauth
  class << self
    attr_accessor :providers
  end
end
