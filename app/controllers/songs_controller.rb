class SongsController < ApplicationController
  before_action :set_song, only: [:show, :edit, :update, :destroy]
  before_action :set_group
  before_action :pagination_params, only: [:index]
  before_action do
    require_group_member(@group)
  end

  def index
    @songs = @group.songs.order(:title)

    #if search_params[:tags_ids].present?
      #tags_ids = (search_params[:tags_ids]).split(',')
      #@songs = @songs.joins(:tags).where('tags.id IN (?)', tags_ids).distinct
    #end

    #if search_params[:query].present?
      #q = "%#{search_params[:query].downcase}%"
      #@songs = @songs.where('lower(title) LIKE ? OR lower(author) LIKE ?', q, q)
    #end

    #calculate_page_count(@songs.count)

    #@songs = @songs.limit(@items_per_page).offset((@page - 1) * @items_per_page)

    respond_to do |format|
      format.html
      format.json
      format.js { render partial: 'songs/songs_list' }
    end
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

  def search_params
    params.permit(:tags_ids, :query, :page, :items_per_page)
  end
end
