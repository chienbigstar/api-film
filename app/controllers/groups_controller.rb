class GroupsController < ApplicationController
  

  def index
    @groups = Group.where(user_id: session['user_id']).order(:id).page(params[:page])
  end

 def new
    @group = Group.new
  end

  def create
    Group.create group_params.merge({user_id: session['user_id']})
    redirect_to groups_path
  end

  def edit
    @group = Group.find_by id: params[:id]
  end

  def update
    group = Group.find_by id: params[:id]
    group.update group_params
    redirect_to edit_group_path(group)
  end

  def destroy
    group = Group.find_by id: params[:id]
    group.delete
    redirect_to groups_path
  end

  private
  def group_params
    params.require(:group).permit :id, :name, :description
  end
end
