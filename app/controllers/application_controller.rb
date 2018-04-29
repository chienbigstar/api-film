class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def redirect_by_logined
    redirect_to pages_path if login?
  end

  def redirect_by_admin
    redirect_to pages_path if is_admin?
  end

  def already_login?
    redirect_to root_path unless login?
  end

  def login?
    return true if @current_user
    username = session[:username]
    return false unless username
    @current_user = User.where(username: username).first
    unless @current_user
      session.delete(:username)
      return false
    end
    true
  end

  def is_admin?
    return true if @is_admin
    if @current_user
      user = @current_user
    else
      username = session[:username];
      user = User.where(username: username).first
    end
    @is_admin = user.admin?
    @is_admin
  end

  def is_editor?
    return @is_editor if @is_editor
    if @current_user
      user = @current_user
    else
      username = session[:username];
      user = User.where(username: username).first
    end
    @is_editor = user.editor?
    @is_editor
  end
end
