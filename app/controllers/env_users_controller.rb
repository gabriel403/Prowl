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
    @env_user = EnvUser.new(env_user_params)

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

    if @env_user.update(env_user_params)
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

  private

    # Never trust parameters from the scary internet, only allow the white list through.
  def env_user_params
    params.require(:env_user).permit(:user_id, :env_id, :access_level_id)
  end
end
