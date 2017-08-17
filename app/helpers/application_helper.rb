module ApplicationHelper
  def login?
    session[:timeout] ||= 0
    session[:username] && Time.now < session[:timeout]
  end
end
