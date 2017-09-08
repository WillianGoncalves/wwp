class ColorsController < ApplicationController
  def index
    @colors = Color.all
    render json: @colors, status: :ok
  end
end
