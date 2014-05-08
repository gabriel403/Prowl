class DeployOptionTypesController < ApplicationController
  # GET /deploy_option_types
  # GET /deploy_option_types.json
  def index
    @deploy_option_types = DeployOptionType.all

    render json: @deploy_option_types
  end

  # GET /deploy_option_types/1
  # GET /deploy_option_types/1.json
  def show
    @deploy_option_type = DeployOptionType.find(params[:id])

    render json: @deploy_option_type
  end

  # POST /deploy_option_types
  # POST /deploy_option_types.json
  def create
    @deploy_option_type = DeployOptionType.new(params[:deploy_option_type])

    if @deploy_option_type.save
      render json: @deploy_option_type, status: :created, location: @deploy_option_type
    else
      render json: @deploy_option_type.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /deploy_option_types/1
  # PATCH/PUT /deploy_option_types/1.json
  def update
    @deploy_option_type = DeployOptionType.find(params[:id])

    if @deploy_option_type.update(params[:deploy_option_type])
      head :no_content
    else
      render json: @deploy_option_type.errors, status: :unprocessable_entity
    end
  end

  # DELETE /deploy_option_types/1
  # DELETE /deploy_option_types/1.json
  def destroy
    @deploy_option_type = DeployOptionType.find(params[:id])
    @deploy_option_type.destroy

    head :no_content
  end
end
