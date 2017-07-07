class DomainsController < ApplicationController
  def login
    @ip = request.env["REMOTE_ADDR"]
  end
end
