class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :user_signed_in?

  layout :choose_layout

  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end

  def user_signed_in?
  	return true if session[:user_id]
  	false
  end

  private

  def choose_layout
  	return 'not_logged' if !user_signed_in?
    session[:role]
  end
end