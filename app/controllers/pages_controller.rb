class PagesController < ApplicationController
  before_action :set_auth

  def home
  	@posts = Post.all
    @newPost = Post.new
    @followers_count = "<%= current_user.followers.count %> needs to be here"
  end

  def profile
    if (User.find_by(:id => params[:id]))
      @id = params[:id]
      @profile_image = User.find_by(:id => params[:id]).profile_image
    else
      redirect_to root_path, :notice=> "User not found"
    end
  	@posts = Post.all.where("user_id = ?", User.find_by(:id => @id))
    @newPost = Post.new
    @toFollow = User.all.last(5)
    @follow_button = "<%= render '/components/follow_button', :user => @user %> needs to be here"
    @followers_count = "<%= @user.followers.count %> needs to be here after I create follow relationships and @user member variable corresponding to the page I'm on"
  end

  private
  def set_auth
  	auth = session[:omniauth] if session[:omniauth]
  end
end
