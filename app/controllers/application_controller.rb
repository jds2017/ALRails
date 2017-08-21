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
    session[:cas_user] = params['un'] if params['un']
    session[:cas_user] = 'testuser' if session[:cas_user].nil?
  end

  def create_user
    cookies.signed[:username] = session[:cas_user]
    if User.find_by(username: session[:cas_user]).nil?
      User.create!(username: session[:cas_user], is_admin: false, is_professor: false)
    end
  end
end
