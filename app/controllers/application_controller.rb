class ApplicationController < ActionController::Base
  if Rails.env.production?
    before_action CASClient::Frameworks::Rails::Filter
  else
    before_action :development_login
  end
  before_action :create_user
  protect_from_forgery with: :exception
  helper_method :current_user

  private

  def current_user
    User.find_by(username: session[:cas_user])
  end

  def development_login
    if params['un']
      session[:cas_user] = params['un']
    else
      if Rails.env == 'test'
        session[:cas_user] = User.find_by(is_admin: true).username
      else
        session[:cas_user] = User.find_by(username: 'rkalhan4').username
      end
    end
  end

  def create_user
    cookies.signed[:username] = session[:cas_user]
    if User.find_by(username: session[:cas_user]).nil?
      User.create username: session[:cas_user]
    end
  end
end
