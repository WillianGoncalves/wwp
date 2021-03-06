class PresentationsController < ApplicationController
  include PresentationsHelper

  before_action :set_presentation, only: [:show, :edit, :update, :play]
  before_action :set_group, except: [:play]
  before_action do
    require_group_member(@group || @presentation.group)
  end

  def index
    @year  = params[:year] || DateTime.now.year
    @month = params[:month] || DateTime.now.month

    if (1..12).to_a.include?(@month.to_i)
      @presentations = @group.presentations.where('extract(month from date_time) = ?', @month).where('extract(year from date_time) = ?', @year).order(:date_time)
    else
      @presentations = @group.presentations.where('extract(year from date_time) = ?', @year).order(:date_time)
    end
  end

  def show; end

  def new
    @presentation = @group.presentations.build
  end

  def edit
    @date = presentation_date(@presentation)
    @time = presentation_time(@presentation)
  end

  def create
    @presentation = @group.presentations.build(presentation_params)
    @presentation.date_time = create_date_time
    add_songs
    @presentation.validate

    if @presentation.save
      redirect_to group_presentations_path(@group)
    else
      render :new
    end
  end

  def update
    @presentation.date_time = create_date_time
    @presentation.presentation_songs.destroy_all
    add_songs

    if @presentation.update(presentation_params)
      redirect_to group_presentations_path(@group)
    else
      render :edit, status: :bad_request
    end
  end

  def destroy
    Presentation.destroy(params[:id])
    redirect_to group_presentations_path(@group)
  end

  def play
    render :play, layout: 'blank'
  end

  private
  def set_presentation
    @presentation = Presentation.find(params[:id])
  end

  def presentation_params
    params.require(:presentation).permit(:local)
  end

  def add_songs
    if params[:song_ids].present?
      songs = params[:song_ids].split(",").map { |id| @group.songs.find(id) }
      songs.each { |song| @presentation.add_song(song) }
    end
  end

  def create_date_time
    @date = params[:date]
    @time = params[:time]

    if @date.present? && @time.present?
      DateTime.parse("#{@date} #{@time}")
    else
      flash.now[:date] = I18n.t('activerecord.custom_errors.presentation.date') unless @date.present?
      flash.now[:time] = I18n.t('activerecord.custom_errors.presentation.time') unless @time.present?
      return nil
    end
  end
end
