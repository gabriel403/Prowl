class DeployStepTypesController < ApplicationController
  load_and_authorize_resource

  # GET /deploy_step_types
  # GET /deploy_step_types.json
  def index
    @deploy_step_types = DeployStepType.all

    render json: @deploy_step_types
  end

  # GET /deploy_step_types/1
  # GET /deploy_step_types/1.json
  def show
    @deploy_step_type = DeployStepType.find(params[:id])

    render json: @deploy_step_type
  end

  # POST /deploy_step_types
  # POST /deploy_step_types.json
  def create
    @deploy_step_type = DeployStepType.new(params[:deploy_step_type])

    if @deploy_step_type.save
      render json: @deploy_step_type, status: :created, location: @deploy_step_type
    else
      render json: @deploy_step_type.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /deploy_step_types/1
  # PATCH/PUT /deploy_step_types/1.json
  def update
    @deploy_step_type = DeployStepType.find(params[:id])

    if @deploy_step_type.update(params[:deploy_step_type])
      head :no_content
    else
      render json: @deploy_step_type.errors, status: :unprocessable_entity
    end
  end

  # DELETE /deploy_step_types/1
  # DELETE /deploy_step_types/1.json
  def destroy
    @deploy_step_type = DeployStepType.find(params[:id])
    @deploy_step_type.destroy

    head :no_content
  end
end
