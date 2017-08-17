class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def login?
    true
    session[:timeout] ||= 0
    session[:username] && Time.now < session[:timeout]
  end

  def redirect_by_logined
    redirect_to dashboard_index_path if login?
  end

  def already_login?
    redirect_to root_path unless login?
  end
end
