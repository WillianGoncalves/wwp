class TagsController < ApplicationController
  before_action :set_group
  before_action do
    require_group_member(@group)
  end

  def index
    @tag = Tag.new
    @tags = @group.tags

    respond_to do |format|
      format.html
      format.json
    end
  end

  def edit
    @tag = @group.tags.find(params[:id])
  end

  def create
    @tag = @group.tags.build(tag_params)
    if @tag.save
      redirect_to group_tags_path(@group)
    else
      @tags = @group.tags
      render :index
    end
  end

  def update
    @tag = @group.tags.find(params[:id])
    if @tag.update(tag_params)
      redirect_to group_tags_path(@group)
    else
      render :edit
    end
  end

  def destroy
    @group.tags.delete(params[:id])
    redirect_to group_tags_path(@group)
  end

  private
  def tag_params
    params.require(:tag).permit(:name, :color_id)
  end
end
