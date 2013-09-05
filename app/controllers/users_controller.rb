class UsersController < Devise::RegistrationsController  
  before_action :authorize, only: [:avatar, :crop]
  before_action :find_user, only: [:show]
  
  def avatar
  end
  
  def crop
    crop_params = params.require(:user).permit(:crop_x, :crop_y, :crop_w, :crop_h)
    unless @user.update(crop_params)
      render action: 'avatar'
    end
    redirect_to user_path(@user)
  end
  
  def show
  end
  

  private
    def authorize
      @user = User.find(params[:id])
      unless @user && current_user && @user == current_user
        redirect_to new_user_session_path
      end 
    end
    
    def find_user
      @user = User.find(params[:id])
    end
end