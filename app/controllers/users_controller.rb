class UsersController < ApplicationController
    before_action :authenticate_user!
    
    def index
      @users = User.all
      @users = @users - [current_user]
      @all_friends = current_user.friends.all
    end
  
    def show
      @user = User.find(params[:id])
      @all_users = User.all
      @friends = current_user.friends.all
      @posts = Post.includes(:user).where(user_id: @user.id).order(created_at: :desc )
    end
  end