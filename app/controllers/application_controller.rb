class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def login?
    session[:username] ? true : false
  end

  def redirect_by_logined
    redirect_to pages_path if login?
  end

  def already_login?
    redirect_to root_path unless login?
  end

  def is_admin?
    session[:username] == 'lvcchien'
  end
end
