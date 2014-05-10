class DeploysController < ApplicationController
  load_and_authorize_resource

  # GET /deploys
  # GET /deploys.json
  def index
    @deploys = Deploy.all

    render json: @deploys
  end

  # GET /deploys/1
  # GET /deploys/1.json
  def show
    @deploy = Deploy.find(params[:id])

    render json: @deploy
  end

  # POST /deploys
  # POST /deploys.json
  def create
    @deploy = Deploy.new(deploy_params)

    if @deploy.save
      render json: @deploy, status: :created, location: @deploy
    else
      render json: @deploy.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /deploys/1
  # PATCH/PUT /deploys/1.json
  def update
    @deploy = Deploy.find(params[:id])

    if @deploy.update(deploy_params)
      head :no_content
    else
      render json: @deploy.errors, status: :unprocessable_entity
    end
  end

  # DELETE /deploys/1
  # DELETE /deploys/1.json
  def destroy
    @deploy = Deploy.find(params[:id])
    @deploy.destroy

    head :no_content
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
  def deploy_params
    params.require(:deploy).permit(:status, :output, :server_id, :env_id, :user_id)
  end
end
