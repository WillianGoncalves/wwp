class MembersController < ApplicationController
  def create
    @members = []
    @group = Group.find(params[:group_id])

    begin
      params[:members].each do |member|
        @member = Member.new(member_params(member))
        @member.group = @group
        if @member.valid?
          @members << @member
        else
          raise
        end
      end

      @members.each do |member|
        member.save
      end

      respond_to do |format|
        format.json { render template: 'groups/_members.json.jbuilder', locals: { members: @group.members } }
      end
    rescue Exception => msg
      respond_to do |format|
        format.json { render json: msg, status: :bad_request }
      end
    end
  end

  private
  def member_params(params)
    params.permit(:user_id)
  end
end
