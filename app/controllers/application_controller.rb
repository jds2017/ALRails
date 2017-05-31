class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user

  before_action :require_login

  private

  def current_user
      User.where(username: session[:username]).first
  end

  def require_login
    if params['un'].first
      session[:username] = params['un']
      return
    end

    if current_user.nil?
      session[:username] = User.first.username
    end
  end
end
