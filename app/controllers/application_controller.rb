class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user

  before_action :require_login

  private

  def current_user
      User.find_by(username: session[:username])
  end

  def require_login
    if params['un']
      cookies.signed[:username] = params['un']
      session[:username] = params['un']
      return
    end

    if current_user.nil?
      session[:username] = User.first.username
    end
  end
end
