class SongsController < ApplicationController
  before_action :set_song, only: [:show, :edit, :update, :destroy]
  before_action :set_group
  before_action do
    require_group_member(@group)
  end

  def index
    @songs = @group.songs.order(:title)
  end

  def show
    @last_presentation = @song.last_presentation
    @next_presentation = @song.next_presentation
  end

  def new
    @song = Song.new
  end

  def edit; end

  def create
    @song = @group.songs.build(song_params)
    if @song.save
      redirect_to group_songs_path(@group)
    else
      render :new, status: :bad_request
    end
  end

  def update
    if @song.update(song_params)
      redirect_to group_songs_path(@group)
    else
      render :edit, status: :bad_request
    end
  end

  def destroy
    Song.destroy(params[:id])
    redirect_to group_songs_path(@group)
  end

  def authors
    @authors = @group.songs.map(&:author).uniq.sort
    render json: @authors
  end

  private
  def set_song
    @song = Song.find(params[:id])
  end

  def song_params
    params.require(:song).permit(:title, :author, :tone, tag_ids: [])
  end
end
