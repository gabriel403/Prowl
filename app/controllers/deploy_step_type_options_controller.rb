class DeployStepTypeOptionsController < ApplicationController
  load_and_authorize_resource

  # GET /deploy_step_type_options
  # GET /deploy_step_type_options.json
  def index
    @deploy_step_type_options = DeployStepTypeOption.all

    render json: @deploy_step_type_options
  end

  # GET /deploy_step_type_options/1
  # GET /deploy_step_type_options/1.json
  def show
    @deploy_step_type_option = DeployStepTypeOption.find(params[:id])

    render json: @deploy_step_type_option
  end

  # POST /deploy_step_type_options
  # POST /deploy_step_type_options.json
  def create
    @deploy_step_type_option = DeployStepTypeOption.new(deploy_step_type_option_params)

    if @deploy_step_type_option.save
      render json: @deploy_step_type_option, status: :created, location: @deploy_step_type_option
    else
      render json: @deploy_step_type_option.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /deploy_step_type_options/1
  # PATCH/PUT /deploy_step_type_options/1.json
  def update
    @deploy_step_type_option = DeployStepTypeOption.find(params[:id])

    if @deploy_step_type_option.update(deploy_step_type_option_params)
      head :no_content
    else
      render json: @deploy_step_type_option.errors, status: :unprocessable_entity
    end
  end

  # DELETE /deploy_step_type_options/1
  # DELETE /deploy_step_type_options/1.json
  def destroy
    @deploy_step_type_option = DeployStepTypeOption.find(params[:id])
    @deploy_step_type_option.destroy

    head :no_content
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def deploy_step_type_option_params
      params.require(:deploy_step_type_option).permit(:name, :deploy_step_type_id)
    end
end
