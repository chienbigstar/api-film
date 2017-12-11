module ApplicationHelper
  def login?
    session[:username]
  end
end
