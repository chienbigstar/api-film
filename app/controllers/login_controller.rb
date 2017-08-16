class LoginController < ApplicationController
  before_action :redirect_by_logined

  def create
    user = User.find_by login_params
    if user
      session['username'] = user.username
      session['timeout'] = Time.now + 15.minutes
      redirect_to dashboard_index_path
    end
  end

  private
  def login_params
    params.permit :username, :password
  end
end
