class JoinRequestsController < ApplicationController
  before_action :set_group, only: [:index, :create]
  before_action :set_join_request, only: [:accept, :reject]
  before_action only: [:index, :accept, :reject] do
    require_group_admin(@group || @join_request.group)
  end

  def index
    @join_requests = @group.join_requests_to_be_accepted
  end

  def create
    if current_user.is_admin_of?(@group)
      return render plain: I18n.t('messages.already_a_member'), status: :bad_request
    end

    @join_request = @group.join_requests.build(join_request_params)
    @join_request.user = current_user

    if @join_request.save
      render plain: I18n.t('messages.join_request_sended'), status: :ok
    else
      render json: @join_request.errors.full_messages, status: :bad_request
    end
  end

  def accept
    if @join_request.accepted.nil?
      @join_request.update(accepted: true)
      @join_request.group.add_member!(@join_request.user)
    end
    redirect_to group_join_requests_path(@join_request.group)
  end

  def reject
    @join_request.update(accepted: false) if @join_request.accepted.nil?
    redirect_to group_join_requests_path(@join_request.group)
  end

  private
  def join_request_params
    params.require(:join_request).permit(:accepted)
  end

  def set_join_request
    @join_request = JoinRequest.find(params[:id])
  end
end
