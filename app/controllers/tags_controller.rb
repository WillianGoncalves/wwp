class TagsController < ApplicationController
  def index
    @tag = Tag.new
    @tags = current_group.tags
  end

  def edit
    @tag = current_group.tags.find(params[:id])
  end

  def create
    @tag = current_group.tags.build(tag_params)
    if @tag.save
      redirect_to group_tags_path(current_group)
    else
      @tags = current_group.tags
      render :index, status: :bad_request
    end
  end

  def update
    @tag = current_group.tags.find(params[:id])
    if @tag.update(tag_params)
      redirect_to group_tags_path(current_group)
    else
      render :edit, status: :bad_request
    end
  end

  def destroy
    Tag.delete(params[:id])
    redirect_to group_tags_path(current_group)
  end

  private
  def tag_params
    params.require(:tag).permit(:name, :color_id)
  end
end
