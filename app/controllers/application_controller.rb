# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def require_user
    unless logged_in?
      flash[:danger] = 'You need to be logged in to perform that action'
      redirect_to root_path
    end
  end

  rescue_from CanCan::AccessDenied do |exception|
    flash[:danger] = exception.message
    redirect_to root_path
  end
end
