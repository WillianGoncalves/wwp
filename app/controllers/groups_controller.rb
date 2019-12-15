class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :candidates]
  before_action only: [:edit, :update] do
    require_group_admin(@group)
  end
  before_action only: [:candidates] do
    require_group_member(@group)
  end

  def index
    @user_groups = current_user.groups
    @other_groups = Group.all - @user_groups
  end

  def show
    @next_presentation = @group.next_presentation
    current_user.update(last_group: @group) if current_user.groups.include?(@group)

    respond_to do |format|
      format.html
      format.json
    end
  end

  def new
    @group = Group.new
  end

  def edit; end

  def create
    @group = Group.new(group_params)
    @group.add_admin(current_user)
    if @group.save
      current_user.update(last_group: @group)
      redirect_to group_path(@group)
    else
      render :new
    end
  end

  def update
    if @group.update(group_params)
      redirect_to group_path(@group)
    else
      render :edit
    end
  end

  def candidates
    users = @group.members.map(&:user)
    @candidates = User.all - users
    @candidates.sort_by! { |user| user.first_name }

    render json: @candidates
  end

  private

  def group_params
    params.require(:group).permit(:name, :image)
  end

  def set_group
    @group = Group.find(params[:id])
  end
end
