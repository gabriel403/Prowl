class AccessLevelsController < ApplicationController
  load_and_authorize_resource

  # GET /access_levels
  # GET /access_levels.json
  def index
    @access_levels = AccessLevel.all

    render json: @access_levels
  end

  # GET /access_levels/1
  # GET /access_levels/1.json
  def show
    @access_level = AccessLevel.find(params[:id])

    render json: @access_level
  end

  # POST /access_levels
  # POST /access_levels.json
  def create
    @access_level = AccessLevel.new(params[:access_level])

    if @access_level.save
      render json: @access_level, status: :created, location: @access_level
    else
      render json: @access_level.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /access_levels/1
  # PATCH/PUT /access_levels/1.json
  def update
    @access_level = AccessLevel.find(params[:id])

    if @access_level.update(params[:access_level])
      head :no_content
    else
      render json: @access_level.errors, status: :unprocessable_entity
    end
  end

  # DELETE /access_levels/1
  # DELETE /access_levels/1.json
  def destroy
    @access_level = AccessLevel.find(params[:id])
    @access_level.destroy

    head :no_content
  end
end
