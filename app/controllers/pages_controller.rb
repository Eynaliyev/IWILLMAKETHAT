class PagesController < ApplicationController
  before_action :set_auth

  def home
  	@posts = Post.all
    @newPost = Post.new
    @post_form = "<%= render '/components/post_form' %><br> needs to be there"
    @followers_count = "<%= current_user.followers.count %> needs to be here"
  end

  def profile
  	@posts = Post.all
    @newPost = Post.new
    @toFollow = User.all.last(5)
    @post_form = "<%= render '/components/post_form' %><br><br>
 needs to be here"
    @follow_button = "<%= render '/components/follow_button', :user => @user %> needs to be here"
    @followers_count = "<%= @user.followers.count %> needs to be here after I create follow relationships and @user member variable corresponding to the page I'm on"
  end

  private
  def set_auth
  	auth = session[:omniauth] if session[:omniauth]
  end
end
