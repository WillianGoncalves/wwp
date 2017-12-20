class PresentationsController < ApplicationController
  def index
    @month = if params[:month].present? then params[:month] else DateTime.now.month end
    @year = if params[:year].present? then params[:year] else DateTime.now.year end
    @presentations = current_group.presentations.where('extract(month from date_time) = ?', @month).where('extract(year from date_time) = ?', @year)
  end

  def show
    @presentation = Presentation.find(params[:id])
  end

  def new
    flash[:date] = flash[:time] = nil
    @presentation = current_group.presentations.build
  end

  def edit
    @presentation = Presentation.find(params[:id])
    @date = @presentation.date
    @time = @presentation.time
  end

  def create
    @presentation = current_group.presentations.build(presentation_params)
    @presentation.date_time = create_date_time
    add_songs
    @presentation.validate

    if @presentation.save
      redirect_to group_presentations_path(current_group)
    else
      render :new, status: :bad_request
    end
  end

  def update
    @presentation = Presentation.find(params[:id])
    @presentation.date_time = create_date_time
    @presentation.presentation_songs.destroy_all
    add_songs

    if @presentation.update(presentation_params)
      redirect_to group_presentations_path(current_group)
    else
      render :edit, status: :bad_request
    end
  end

  def destroy
    Presentation.destroy(params[:id])
    redirect_to group_presentations_path(current_group)
  end

  private
  def presentation_params
    params.require(:presentation).permit(:local)
  end

  def add_songs
    if params[:song_ids].present?
      songs = params[:song_ids].split(",").map { |id| Song.find(id) }
      songs.each { |song| @presentation.add_song(song) }
    end
  end

  def create_date_time
    @date = params[:date]
    @time = params[:time]
    flash[:date] = flash[:time] = nil

    if @date.present? && @time.present?
      DateTime.parse("#{@date} #{@time}")
    else
      flash[:date] = I18n.t('activerecord.custom_errors.presentation.date') unless @date.present?
      flash[:time] = I18n.t('activerecord.custom_errors.presentation.time') unless @time.present?
      return nil
    end
  end
end
