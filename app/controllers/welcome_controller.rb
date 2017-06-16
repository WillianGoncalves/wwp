class WelcomeController < ApplicationController
  def index
    redirect_to group_path(current_user.last_group) unless current_user.last_group.nil?
    redirect_to groups_path
  end
end
