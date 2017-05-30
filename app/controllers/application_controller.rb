class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :require_login

  private

  def require_login
    unless session[:username]
      session[:username] = 'jtompkins8'
    end
  end
end
