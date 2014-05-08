class AppsController < ApplicationController
  load_and_authorize_resource

  # GET /apps
  # GET /apps.json
  def index
    @apps = current_user.apps

    render json: @apps
  end

  # GET /apps/1
  # GET /apps/1.json
  def show
    @app = App.find(params[:id])

    render json: @app
  end

  # POST /apps
  # POST /apps.json
  def create
    @app = App.new(params[:app])

    if @app.save
      render json: @app, status: :created, location: @app
    else
      render json: @app.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /apps/1
  # PATCH/PUT /apps/1.json
  def update
    @app = App.find(params[:id])

    if @app.update(params[:app])
      head :no_content
    else
      render json: @app.errors, status: :unprocessable_entity
    end
  end

  # DELETE /apps/1
  # DELETE /apps/1.json
  def destroy
    @app = App.find(params[:id])
    @app.destroy

    head :no_content
  end
end
