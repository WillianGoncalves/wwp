class GroupsController < ApplicationController
  def index
    @groups = Group.all - current_user.groups
  end

  def show
    @group = Group.find(params[:id])
    current_user.update(last_group: @group) if current_user.groups.include?(@group)
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    group_admin = Member.new(user: current_user, admin: true)
    @group.members << group_admin
    if @group.save
      current_user.update(last_group: @group)
      redirect_to group_path(@group)
    else
      render :new, status: :bad_request
    end
  end

  def candidates
    users = current_group.members.map(&:user)
    @candidates = User.all - users

    respond_to do |format|
      format.json
    end
  end

  private

  def group_params
    params.require(:group).permit(:name, :image)
  end
end
