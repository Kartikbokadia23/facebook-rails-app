class SessionsController < ApplicationController
    def create
      @user = User.from_omniauth(auth_hash)
      session[:user_id] = @user.id
      sign_in @user, event: :authentication
      redirect_to root_url
    end
  
    private
  
    def auth_hash
      request.env['omniauth.auth']
    end
  end