class TagsController < ApplicationController
  def index
    @tag = Tag.new
    @tags = Tag.all.order(:name)
  end

  def edit
    @tag = Tag.find(params[:id])
  end

  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      redirect_to tags_path
    else
      @tags = Tag.all.order(:name)
      render :index, status: :bad_request
    end
  end

  def update
    @tag = Tag.find(params[:id])
    if @tag.update(tag_params)
      redirect_to tags_path
    else
      render :edit, status: :bad_request
    end
  end

  def destroy
    Tag.delete(params[:id])
    redirect_to tags_path
  end

  private
  def tag_params
    params.require(:tag).permit(:name, :color_id)
  end
end
