class DeployStepsController < ApplicationController

  def show
    @deploy_step = DeployStep.find(params[:id])
  end

  def new
    @env         = Environment.find(params[:env_id])
    @deploy_step = DeployStep.new
    @url         = deploy_steps_path(@deploy_step, :env_id => @env.id)
    respond_to do |format|
      format.html
      format.json
    end
  end

  def edit
    @deploy_step = DeployStep.find(params[:id])
    @deploy_step.additional = @deploy_step.additional.to_json
    @url = deploy_step_path(@deploy_step)
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
    @deploy_step.environment = Environment.find(params[:env_id])

    respond_to do |format|
      if @deploy_step.save
        flash[:notice] = "Step saved"
        format.html { redirect_to @deploy_step.environment }
        format.js { render :partial => 'show', :deploy_step => @deploy_step, status: :created, location: @deploy_steps }
      else
        flash[:alert] = "Step save error"
        format.html { redirect_to @deploy_step.environment }
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

  def clone
    fromenv = Environment.find(params[:clone_deploy_steps][:from_env_id])
    toenv   = Environment.find(params[:clone_deploy_steps][:to_env_id])

    fromenv.deploy_steps.each do |deploy_step|
      nds = deploy_step.dup
      nds.environment = toenv
      nds.save
    end

    respond_to do |format|
      flash[:notice] = "Steps cloned"
      format.html { redirect_to toenv }
    end
  end

  def clear
    env = Environment.find(params[:clear_deploy_steps][:envid])
    env.deploy_steps.destroy_all
    respond_to do |format|
      flash[:notice] = "Steps cleared"
      format.html { redirect_to env }
      format.json { render :partial => 'environments/show', :environment => env, status: :created, location: env }
    end
  end

  private
  def save_params
    params.require(:deploy_step).permit(:order, :name, :value, :deploy_step_type_option_id, :additional)
  end
end
