class EnvsController < ApplicationController
  load_and_authorize_resource

  # GET /envs
  # GET /envs.json
  def index
    @envs = Env.all

    render json: @envs
  end

  # GET /envs/1
  # GET /envs/1.json
  def show
    @env = Env.find(params[:id])

    render json: @env
  end

  # POST /envs
  # POST /envs.json
  def create
    @env = Env.new(params[:env])

    if @env.save
      render json: @env, status: :created, location: @env
    else
      render json: @env.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /envs/1
  # PATCH/PUT /envs/1.json
  def update
    @env = Env.find(params[:id])

    if @env.update(params[:env])
      head :no_content
    else
      render json: @env.errors, status: :unprocessable_entity
    end
  end

  # DELETE /envs/1
  # DELETE /envs/1.json
  def destroy
    @env = Env.find(params[:id])
    @env.destroy

    head :no_content
  end
end