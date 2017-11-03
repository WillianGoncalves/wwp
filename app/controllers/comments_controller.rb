class CommentsController < ApplicationController
  before_action :find_target

  def new
    @comment = @target.comments.build
  end

  def edit
    @comment = @target.comments.find(params[:id])
  end

  def create
    @comment = @target.comments.build(comment_params)
    @comment.commenter = current_user
    if @comment.save
      redirect_to target_path
    else
      render :edit, status: :bad_request
    end
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      redirect_to target_path
    else
      render :edit, status: :bad_request
    end
  end

  def destroy
    Comment.destroy(params[:id])
    redirect_to target_path
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def find_target
    if params[:song_id].present?
      @target = Song.find(params[:song_id])
    else
      @target = Presentation.find(params[:presentation_id])
    end
  end

  def target_path
    if @target.is_a? Song
      group_song_path(current_group, @target)
    else
      #TODO - group presentation path
    end
  end
end
