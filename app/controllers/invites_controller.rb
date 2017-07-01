class InvitesController < ApplicationController

  def index
    @group = Group.find(params[:group_id])
    respond_to do |format|
      format.json { render template: 'groups/invites.json.jbuilder', locals: { invites: @group.invites_to_be_accepted } }
    end
  end

  def create
    @invites = []
    @group = Group.find(params[:group_id])

    begin
      params[:invites].each do |invite|
        @invite = Invite.new(invite_params(invite))
        @invite.group = @group
        if @invite.valid?
          @invites << @invite
        else
          raise
        end
      end

      @invites.each do |invite|
        invite.save
      end

      respond_to do |format|
        format.json { render template: 'groups/invites.json.jbuilder', locals: { invites: @group.invites_to_be_accepted } }
      end
    rescue Exception => msg
      respond_to do |format|
        format.json { render json: msg, status: :bad_request }
      end
    end
  end

  private
  def invite_params(params)
    params.permit(:user_id)
  end
end
