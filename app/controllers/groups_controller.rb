class GroupsController < ApplicationController
  def index
    @groups = Group.all - current_user.groups
  end

  def show
    @group = Group.find(params[:id])
    current_user.update(last_group: @group) if current_user.groups.include?(@group)
  end
end
