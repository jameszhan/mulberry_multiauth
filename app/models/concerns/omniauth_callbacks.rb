module OmniauthCallbacks
  extend ActiveSupport::Concern
  
  included do
    has_many :authentications, :dependent => :destroy
    scope :find_by_omniauth, ->(omniauth){ joins(:authentications).where(authentications: omniauth.slice(:provider, :uid)).readonly(false) }  
  end  
  
  def bind_auth?(provider)
    authentications.where(provider: provider).first
  end    
  
  def bind_omniauth(omniauth)
    auth = omniauth.slice(:provider, :uid).to_hash
    auth.merge!(access_token: omniauth.credentials.token) if omniauth.credentials
    authentications.create(auth)
  end
  
  module ClassMethods  

    def from_omniauth(omniauth) 
      user = find_by_omniauth(omniauth).first
      unless user
        user = new(login_type: 'omniauth') do |user|
          user.email = omniauth.info.email if omniauth.info
          user.password = Devise.friendly_token[0, 20]
          user.name = omniauth.info.nickname          
          auth = omniauth.slice(:provider, :uid).to_hash
          auth.merge!(access_token: omniauth.credentials.token) if omniauth.credentials
          user.authentications.build(auth)
        end  
        #user.save!(validate: false)
        user.save
      end
      user
    end  
  end
end