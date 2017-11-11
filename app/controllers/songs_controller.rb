class SongsController < ApplicationController
  def index
    @songs = current_group.songs
  end

  def show
    @song = Song.find(params[:id])
  end

  def new
    @song = Song.new
  end

  def edit
    @song = Song.find(params[:id])
  end

  def create
    @song = current_group.songs.build(song_params)
    if @song.save
      redirect_to group_path(current_group)
    else
      render :new, status: :bad_request
    end
  end

  def update
    @song = current_group.songs.find(params[:id])
    if @song.update(song_params)
      redirect_to group_path(current_group)
    else
      render :edit, status: :bad_request
    end
  end

  def destroy
    Song.destroy(params[:id])
    redirect_to group_songs_path(current_group)
  end

  private
  def song_params
    params.require(:song).permit(:title, :author, :tone, tag_ids: [])
  end
end
