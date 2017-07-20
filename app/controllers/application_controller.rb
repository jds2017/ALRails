class ApplicationController < ActionController::Base
  if Rails.env.production?
    before_action CASClient::Frameworks::Rails::Filter
  end
  protect_from_forgery with: :exception
  helper_method :current_user

  before_action :require_login

  private

  def current_user
    if Rails.env.production?
      if User.find_by(username: session[:cas_user]).nil?
        User.create username: session[:cas_user]
      end
      User.find_by(username: session[:cas_user])
    else
      User.find_by(username: session[:username])
    end
  end

  def require_login
    if params['un']
      cookies.signed[:username] = params['un']
      session[:username] = params['un']
      return
    end

    if current_user.nil?
      if Rails.env == 'test'
        session[:username] = User.first.username
        return
      end
      session[:username] = User.find_by(username: 'rkalhan4').username
    end
  end
end
