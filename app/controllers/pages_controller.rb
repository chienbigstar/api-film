class PagesController < ApplicationController
  def index
    if params[:search]
      @value = params[:value]
      @pages = Page.where("name like '%#{params[:value]}%'");
    else
      @pages = Page.all
    end
  end

  def new
    @page = Page.new
  end

  def create
    Page.create page_params
    redirect_to pages_path
  end

  private
  def page_params
    params.require(:page).permit :id, :name, :description, :coin, :content
  end
end
