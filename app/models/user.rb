class User < ActiveRecord::Base
  include DeviseCallbacks
  include OmniauthCallbacks  
  
  mount_uploader :avatar, AvatarUploader   

  after_update :crop_avatar

  def crop_avatar
    avatar.recreate_versions! if changes.include?(:avatar) || !changed.select{|e| e.start_with?('crop_')}.empty?
  end
  
end
