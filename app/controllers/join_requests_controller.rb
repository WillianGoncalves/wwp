class JoinRequestsController < ApplicationController
  def index
    @group = Group.find(params[:group_id])
    @join_requests = @group.join_requests.where(accepted: nil)
  end

  def create
    @group = Group.find(params[:group_id])
    @join_request = @group.join_requests.build(join_request_params)
    @join_request.user = current_user

    if @join_request.save
      render plain: I18n.t('notifications.join_request_sended'), status: :ok
    else
      render json: @join_request.errors.full_messages, status: :bad_request
    end
  end

  def accept
    @join_request = JoinRequest.find(params[:id])
    @join_request.update(accepted: true)

    group = @join_request.group
    group.members.create(user: @join_request.user)

    if group.join_requests_to_be_accepted.any?
      redirect_to group_join_requests_path(group)
    else
      redirect_to group_path(group)
    end
  end

  def reject
    @join_request = JoinRequest.find(params[:id])
    @join_request.update(accepted: false)

    group = @join_request.group

    if group.join_requests_to_be_accepted.any?
      redirect_to group_join_requests_path(group)
    else
      redirect_to group_path(group)
    end
  end

  private
  def join_request_params
    params.require(:join_request).permit(:accepted)
  end
end
