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
  def authenticate_user!
  	if current_user
  		return true
  	else
  		redirect_to root_path, :notice=> "You need to log in before doing this"
  	end
  end

  helper_method :authenticate_user!

end
