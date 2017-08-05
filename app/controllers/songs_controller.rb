class SongsController < ApplicationController
  def new
    @group = Group.find(params[:group_id])
    @song = Song.new
  end

  def edit
    @group = Group.find(params[:group_id])
    @song = @group.songs.find(params[:id])
  end

  def create
    @group = Group.find(params[:group_id])
    @song = @group.songs.build(song_params)
    if @song.save
      redirect_to group_path(@group)
    else
      render :new, status: :bad_request
    end
  end

  def update
    @group = Group.find(params[:group_id])
    @song = @group.songs.find(params[:id])
    if @song.update(song_params)
      redirect_to group_path(@group)
    else
      render :edit, status: :bad_request
    end
  end

  private
  def song_params
    params.require(:song).permit(:title, :author, :tone, tag_ids: [])
  end
end
