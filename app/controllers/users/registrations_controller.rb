# encoding: UTF-8
class Users::RegistrationsController < Devise::RegistrationsController 
  before_action :configure_permitted_parameters, only: [:create, :update]
  
  # POST /resource
  def create
    build_resource(sign_up_params)

    if resource.save
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_navigational_format?
        sign_up(resource_name, resource)
        if resource.avatar.present?
          redirect_to avatar_user_path(resource)
        else
          respond_with resource, :location => after_sign_up_path_for(resource)
        end
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
        expire_session_data_after_sign_in!
        respond_with resource, :location => after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      respond_with resource
    end
  end
  
  # PUT /resource
  def update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)
    bypass = (resource.login_type == 'password')
    if bypass ? resource.update_with_password(account_update_params) : resource.update(account_update_params)
      if is_navigational_format?
        flash_key = update_needs_confirmation?(resource, prev_unconfirmed_email) ?
          :update_needs_confirmation : :updated
        set_flash_message :notice, flash_key
      end
      sign_in resource_name, resource, :bypass => bypass
      if params[:user][:avatar].present?
        redirect_to avatar_user_path(resource)
      else
        respond_with resource, :location => after_update_path_for(resource)
      end
    else
      clean_up_passwords resource
      respond_with resource
    end
  end

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up){|u| u.permit(:name, :email, :avatar, :password, :password_confirmation) }
      devise_parameter_sanitizer.for(:account_update) do|u|
        u.permit(:name, :email, :avatar, :password, :password_confirmation, :current_password)
      end
    end
  
end
