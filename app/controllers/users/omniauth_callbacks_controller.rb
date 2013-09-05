# encoding: UTF-8
class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def auth    
    if current_user
      bind_omniauth_account
    else
      login_with_omniauth
    end   
  end
  
  alias_method :github, :auth
  alias_method :weibo, :auth
  alias_method :taobao, :auth
  alias_method :qq_connect, :auth
  
  protected
    def login_with_omniauth
      user = User.from_omniauth(request.env["omniauth.auth"])
      if user.persisted?
        flash.notice = "Signed in!"
        sign_in_and_redirect user
      elsif user.email && User.where(email: user.email).first
        redirect_to new_user_session_path, alert: "用户 #{user.email} 已经存在，你可以先用该账号登陆，然后绑定#{env["omniauth.auth"][:provider]} 帐号。"
      else
        session["devise.user_attributes"] = user.attributes
        redirect_to new_user_registration_path
      end
    end
    
    def bind_omniauth_account
      current_user.bind_omniauth(env["omniauth.auth"]) #Add an auth to existing
      redirect_to edit_user_registration_path, notice: "成功绑定了 #{env["omniauth.auth"][:provider]} 帐号。"
    end
      
end
