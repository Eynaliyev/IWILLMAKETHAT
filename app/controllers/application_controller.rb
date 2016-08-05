class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private
  def current_user
  	@current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  private
  def user_signed_in?
    if current_user
      return true
    else
      return false
    end
  end
  helper_method :user_signed_in?

  private
  def authenticate_user!
    if current_user
      return true
    else
      redirect_to root_path, :notice=> "You need to log in before doing this"
    end
  end
  helper_method :authenticate_user!

  private
  def set_new_post!
    if user_signed_in?
      @newPost = Post.new
    end
  end
  helper_method :set_new_post!

  private
  def set_tags!
    @tags = Tag.all.last(5)
  end
  helper_method :set_tags!

  private
  def set_to_follow!
    @toFollow = User.all.last(5)
  end
  helper_method :set_to_follow!

  private
  def set_auth!
    auth = session[:omniauth] if session[:omniauth]
  end
  helper_method :set_auth!
end
