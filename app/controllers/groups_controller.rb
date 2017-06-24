class GroupsController < ApplicationController
  def index
    @groups = Group.all - current_user.groups    
  end

  def show
  end
end
