class DeployStepsController < ApplicationController
  load_and_authorize_resource

  # GET /deploy_steps
  # GET /deploy_steps.json
  def index
    @deploy_steps = DeployStep.all

    render json: @deploy_steps
  end

  # GET /deploy_steps/1
  # GET /deploy_steps/1.json
  def show
    @deploy_step = DeployStep.find(params[:id])

    render json: @deploy_step
  end

  # POST /deploy_steps
  # POST /deploy_steps.json
  def create
    @deploy_step = DeployStep.new(params[:deploy_step])

    if @deploy_step.save
      render json: @deploy_step, status: :created, location: @deploy_step
    else
      render json: @deploy_step.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /deploy_steps/1
  # PATCH/PUT /deploy_steps/1.json
  def update
    @deploy_step = DeployStep.find(params[:id])

    if @deploy_step.update(params[:deploy_step])
      head :no_content
    else
      render json: @deploy_step.errors, status: :unprocessable_entity
    end
  end

  # DELETE /deploy_steps/1
  # DELETE /deploy_steps/1.json
  def destroy
    @deploy_step = DeployStep.find(params[:id])
    @deploy_step.destroy

    head :no_content
  end
end
