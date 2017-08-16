class HelloController < ApplicationController
  before_action :redirect_by_logined

  def index
  end
end
