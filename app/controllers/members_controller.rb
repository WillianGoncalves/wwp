class MembersController < ApplicationController
  before_action :set_group

  def create
    params[:members].each do |member|
      @group.members.build(member_params(member))
    end

    if @group.save
      head :no_content
    else
      render json: @group.errors.full_messages, status: :bad_request
    end
  end

  def destroy
    @group.members.destroy(params[:id])
    redirect_to group_path(@group)
  end

  private
  def set_group
    @group = Group.find(params[:group_id])
  end

  def member_params(params)
    params.permit(:user_id)
  end
end
