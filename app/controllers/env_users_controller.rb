class EnvUsersController < ApplicationController
  load_and_authorize_resource

  # GET /env_users
  # GET /env_users.json
  def index
    @env_users = EnvUser.all

    render json: @env_users
  end

  # GET /env_users/1
  # GET /env_users/1.json
  def show
    @env_user = EnvUser.find(params[:id])

    render json: @env_user
  end

  # POST /env_users
  # POST /env_users.json
  def create
    @env_user = EnvUser.new(params[:env_user])

    if @env_user.save
      render json: @env_user, status: :created, location: @env_user
    else
      render json: @env_user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /env_users/1
  # PATCH/PUT /env_users/1.json
  def update
    @env_user = EnvUser.find(params[:id])

    if @env_user.update(params[:env_user])
      head :no_content
    else
      render json: @env_user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /env_users/1
  # DELETE /env_users/1.json
  def destroy
    @env_user = EnvUser.find(params[:id])
    @env_user.destroy

    head :no_content
  end
end
