class MembersController < ApplicationController
  def create
    @group = Group.find(params[:group_id])

    params[:members].each do |member|
      @group.members.build(member_params(member))
    end

    if @group.save
      head :no_content
    else
      render json: @group.errors.full_messages, status: :bad_request
    end
  end

  private
  def member_params(params)
    params.permit(:user_id)
  end
end
