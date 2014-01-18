class XhrController < ApplicationController
  def deploy_step_type
    deploy_step_type = DeployStepTypeOption.find(params[:id]).deploy_step_type
    flash[:notice] = "Step saved"
    respond_to do |format|
      format.json { render json: deploy_step_type }
    end
  end
end
