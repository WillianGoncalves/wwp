class CommentsController < ApplicationController
  before_action :set_comment, only: [:update, :destroy]
  before_action :set_target
  before_action only: [:create] do
    require_group_member(@target.group)
  end

  def create
    @comment = @target.comments.build(comment_params)
    @comment.commenter = current_user
    if @comment.save
      redirect_to polymorphic_path([ @target.group, @target ])
    else
      flash[:error] = @comment.errors.full_messages
      redirect_back fallback_location: polymorphic_path([ @target.group, @target ])
    end
  end

  def update
    return redirect_to root_path if @comment.commenter != current_user

    if @comment.update(comment_params)
      redirect_to polymorphic_path([ @target.group, @target ])
    else
      flash[:error] = @comment.errors.full_messages
      redirect_back fallback_location: polymorphic_path([ @target.group, @target ])
    end
  end

  def destroy
    return redirect_to root_path if @comment.commenter != current_user

    Comment.destroy(params[:id])
    redirect_to polymorphic_path([ @target.group, @target ])
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def set_target
    if params[:song_id].present?
      @target = Song.find(params[:song_id])
    elsif params[:presentation_id].present?
      @target = Presentation.find(params[:presentation_id])
    else
      @target = @comment.target
    end
  end
end
