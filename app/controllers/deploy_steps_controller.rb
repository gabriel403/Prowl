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
    @deploy_step = DeployStep.new(deploy_step_params)

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

    if @deploy_step.update(deploy_step_params)
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

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def deploy_step_params
      params.require(:deploy_step).permit(:env_id, :order, :deploy_step_type_option_id, :value, :additional)
    end
end
