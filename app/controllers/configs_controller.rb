class ConfigsController < ApplicationController
  def index
    @configs = Config.all
  end

  def new
    redirect_to configs_path unless is_admin?
    @config = Config.new
  end

  def update
    Config.update config_params
    redirect_to configs_path
  end

  def edit
    redirect_to configs_path unless is_admin?
    @config = Config.find_by id: params[:id]
  end

  def create
    Config.create config_params
    redirect_to configs_path
  end

  def destroy
    redirect_to configs_path unless is_admin?
    config = Config.find_by id: params[:id]
    config.delete
    redirect_to configs_path
  end

  private
  def config_params
    params.require(:config).permit :id, :key, :value
  end
end
