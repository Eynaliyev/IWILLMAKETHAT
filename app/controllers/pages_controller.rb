class PagesController < ApplicationController
  before_action :set_auth

  def home
  	@posts = Post.all
    @newPost = Post.new
    @followers_count = current_user.followers.count
  end

  def profile
    if (User.find_by(:id => params[:id]))
      @id = params[:id]
      @user = User.find_by(:id => params[:id])
      @profile_image = @user.profile_image
    else
      redirect_to root_path, :notice=> "User not found"
    end
  	@posts = Post.all.where("user_id = ?", User.find_by(:id => @id))
    @newPost = Post.new
    @toFollow = User.all.last(5)
    @followers_count = @user.followers.count
  end

  private
  def set_auth
  	auth = session[:omniauth] if session[:omniauth]
  end
end
