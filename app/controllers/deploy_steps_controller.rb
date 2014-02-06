class DeployStepsController < ApplicationController

  def show
    @deploy_step = DeployStep.find(params[:id])
  end

  def new
    @app = App.find(params[:appid])
    @deploy_step = DeployStep.new
    respond_to do |format|
      format.html
      format.json
    end
  end

  def edit
    @deploy_step = DeployStep.find(params[:id])
    @deploy_step.additional = @deploy_step.additional.to_json
    session[:return_to] = request.referer
    respond_to do |format|
      format.html
      format.json
    end
  end

  def create
    @deploy_step = DeployStep.new(save_params)
    if @deploy_step.deploy_step_type_option.deploy_step_type.subtype === "generic"
      @deploy_step.value = ''
    end

    @deploy_step.additional = JSON.parse(@deploy_step.additional)
    @deploy_step.app = App.find(params[:appid])

    respond_to do |format|
      if @deploy_step.save
        flash[:notice] = "Step saved"
        format.js { render :partial => 'show', :deploy_step => @deploy_step, status: :created, location: @deploy_steps }
      else
        flash[:alert] = "Step save error"
        format.json { render json: @deploy_step.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @deploy_step = DeployStep.find(params[:id])

    if @deploy_step.update_attributes(save_params)
      @deploy_step.additional = JSON.parse(@deploy_step.additional)
      @deploy_step.save
      redirect_to session.delete(:return_to), :flash => { :success => 'DeployStep was successfully updated.' }
    else
      render :action => 'edit'
    end
  end

  def destroy
    @deploy_step = DeployStep.find(params[:id])
    @deploy_step.destroy
    redirect_to request.referer, :flash => { :success => 'DeployStep was successfully deleted.' }
  end

  private
  def save_params
    params.require(:deploy_step).permit(:order, :name, :value, :deploy_step_type_option_id, :additional)
  end
end
