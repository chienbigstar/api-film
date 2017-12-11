class PagesController < ApplicationController
  def index
    if params[:search]
      @value = params[:value]
      @pages = Page.where("name like '%#{params[:value]}%'")
    else
      @pages = Page.all
    end
  end

  def new
    redirect_to pages_path unless is_admin?
    @page = Page.new
  end

  def create
    Page.create page_params
    redirect_to pages_path
  end

  def edit
    redirect_to pages_path unless is_admin?
    @page = Page.find_by id: params[:id]
  end

  def update
    page = Page.find_by id: params[:id]
    page.update page_params
    redirect_to pages_path
  end

  def destroy
    redirect_to pages_path unless is_admin?
    page = Page.find_by id: params[:id]
    page.delete
    redirect_to pages_path
  end

  private
  def page_params
    params.require(:page).permit :id, :name, :description, :coin, :content, :time
  end
end
