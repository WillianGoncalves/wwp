class PresentationsController < ApplicationController
  def index
    @presentations = current_group.presentations
  end

  def show
    @presentation = Presentation.find(params[:id])
  end

  def new
    @presentation = current_group.presentations.build
  end

  def edit
    @presentation = Presentation.find(params[:id])
  end

  def create
    @date = params[:date]
    @time = params[:time]

    flash[:date] = flash[:time] = nil
    flash[:date] = I18n.t('activerecord.custom_errors.presentation.date') unless @date.present?
    flash[:time] = I18n.t('activerecord.custom_errors.presentation.time') unless @time.present?

    @presentation = current_group.presentations.build(presentation_params)
    @presentation.date_time = DateTime.parse("#{@date} #{@time}") if @date.present? && @time.present?
    @presentation.validate

    if @presentation.save
      redirect_to group_presentations_path(current_group)
    else
      render :new, status: :bad_request
    end
  end

  def update
    @presentation = Presentation.find(params[:id])
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
    params.require(:presentation).permit(:local, song_ids: [])
  end
end
