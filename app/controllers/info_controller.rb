class InfoController < ApplicationController
  def index
  end

  def login_facebook
  end

  def do_login_facebook
  	@cookie = params[:cookie]
  end

  def anticaptcha
		@apikey = info_params[:apikey]
		@sitekey = info_params[:sitekey]
		@location = info_params[:location]
  end

  def cheapcaptcha
  end

  def banner
  end

  private
  def info_params
    params.permit :apikey, :sitekey, :location
  end
end
