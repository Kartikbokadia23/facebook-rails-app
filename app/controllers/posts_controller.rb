class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @friends = current_user.friends.all
    @friends_list = @friends.limit(10)
    @posts = Post.where(user_id: current_user.friends).or(Post.where(user_id: current_user)).order(created_at: :desc).limit(10)
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to request.referrer
    else
      render :new
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to request.referrer
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    redirect_to user_path(current_user)
  end
  
  private

  def post_params
    params.require(:post).permit(:body)
  end
end