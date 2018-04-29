class LoginController < ApplicationController
  before_action :redirect_by_logined, only: :create

  def create
    user = User.find_by login_params
    if user
      user.update ip: request.remote_ip
      session['username'] = user.username
      session['user_id'] = user.id
      session['timeout'] = Time.now + 15.minutes
      cookies[:user_id] = user.id
      cookies[:ip] = request.remote_ip
      redirect_to pages_path
    end
  end

  def destroy
    session['username'] = nil
    redirect_to root_path
  end

  private
  def login_params
    params.permit :username, :password
  end
end
