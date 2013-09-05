Rails.application.routes.draw do

  devise_for :users, controllers: { 
    omniauth_callbacks: "users/omniauth_callbacks", 
    registrations: "users/registrations" 
  }, path_names: { 
    :sign_in => 'login', 
    :sign_out => 'logout',
    :sign_up => 'register'
  }

  devise_scope :user do
    resources :users, :only => [:show] do
      member do
        post :follow
        get 'avatar'
        patch 'crop'
      end
      collection do
        get "auth/:provider/unbind", to: :auth_unbind, as: :unbind_auth
      end
    end
  end

end