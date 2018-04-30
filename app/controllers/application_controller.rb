class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # rescue_from Exception, with: :internal_server_error

  before_action :check_token

  def check_token
    if login?
      current_ip = request.remote_ip
      user = User.find_by_id(session[:current_user]['id'])
      if current_ip == user.ip
        cookies[:token] = session[:current_user]['token']
        cookies[:ip] = request.remote_ip
      else
        ActionCable.server.broadcast "room_channel_#{user.id}_#{user.ip}", message: 'stop'
        user.update ip: current_ip
        session[:current_user]['ip'] = current_ip
      end
    else
      session.delete(:current_user)
      return false
    end
  end

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
    return true if @login
    current_user = session[:current_user]
    return false unless current_user
    current_user = User.find_by_id current_user['id']
    if !current_user || (current_user.ip != request.remote_ip)
      session.delete(:current_user)
      return false
    end
    @login = true
    @login
  end

  def is_admin?
    return true if @is_admin
    if @current_user
      user = @current_user
    else
      user = User.find_by_id session[:current_user]['id']
    end
    @is_admin = user.admin?
    @is_admin
  end

  def is_editor?
    return @is_editor if @is_editor
    if @current_user
      user = @current_user
    else
      user = User.find_by_id session[:current_user]['id']
    end
    @is_editor = user.editor?
    @is_editor
  end

  def internal_server_error
    session.delete(:current_user)
    redirect_to root_path
  end
end
