module DeviseCallbacks
  extend ActiveSupport::Concern
  included do
    # Include default devise modules. Others available are:
    # :token_authenticatable, :confirmable,
    # :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, 
        :validatable, :omniauthable
        
    self.class_eval do
      ## We need defined these methods in class_eval, or
      ## directly defined them in MODEL class,  
      ## otherwise the devise methods can't be override.  
      def password_required?
        self.login_type == 'password' && super
      end

      def email_required?
        super
      end  
      
      def update_tracked_fields!(request)
        if request.env["omniauth.auth"]
          self.login_type = 'omniauth'
        else
          self.login_type = 'password'
        end
        super
      end
            
      def self.new_with_session(params, session)
        if attrs = session["devise.user_attributes"]
          new(attrs) do|user|
            user.attributes = params
            user.valid? 
          end
        else
          super
        end
      end            
    end
  end
  
end