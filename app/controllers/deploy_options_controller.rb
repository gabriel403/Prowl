class DeployOptionsController < ApplicationController
  load_and_authorize_resource

  # GET /deploy_options
  # GET /deploy_options.json
  def index
    @deploy_options = DeployOption.all

    render json: @deploy_options
  end

  # GET /deploy_options/1
  # GET /deploy_options/1.json
  def show
    @deploy_option = DeployOption.find(params[:id])

    render json: @deploy_option
  end

  # POST /deploy_options
  # POST /deploy_options.json
  def create
    @deploy_option = DeployOption.new(params[:deploy_option])

    if @deploy_option.save
      render json: @deploy_option, status: :created, location: @deploy_option
    else
      render json: @deploy_option.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /deploy_options/1
  # PATCH/PUT /deploy_options/1.json
  def update
    @deploy_option = DeployOption.find(params[:id])

    if @deploy_option.update(params[:deploy_option])
      head :no_content
    else
      render json: @deploy_option.errors, status: :unprocessable_entity
    end
  end

  # DELETE /deploy_options/1
  # DELETE /deploy_options/1.json
  def destroy
    @deploy_option = DeployOption.find(params[:id])
    @deploy_option.destroy

    head :no_content
  end
end
