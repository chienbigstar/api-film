class HelloController < ApplicationController
  before_action :redirect_by_logined

  def index
    render :index, layout: false
  end
end
