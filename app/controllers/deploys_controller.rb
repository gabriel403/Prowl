class DeploysController < ApplicationController
  require_dependency "tasks/deployment"
  require "resque"
  require "remoteserver/deploy_hooks"

  def index
    @environment = Environment.find(params[:id])
  end

  def show
    @deploy = Deploy.find(params[:id])
    respond_to do |format|
      format.html
      format.json
    end
  end

  def new
    @deploy_option_form = DeployOptionForm.new
    @env = Environment.find(params[:id])
    success = true

    if @env.deploy_steps.none? {|ds| ds.deploy_step_type_option.deploy_step_type.name == "destination"}
      flash_message :alert, "No destination deploy_step has been set"
      success = false
      # redirect_to request.referer
    end

    if @env.deploy_steps.none? {|ds| ds.deploy_step_type_option.deploy_step_type.name == "vcs_type"}
      flash_message :alert, "No vcs (git,svn) deploy_step has been set"
      success = false
    end

    if @env.deploy_steps.none? {|ds| ds.deploy_step_type_option.deploy_step_type.name == "deploy_method"}
      flash_message :alert, "No deploy method (pull,clone,export) deploy_step has been set"
      success = false
    end

    if @env.servers.count == 0
      flash_message :alert, "No servers have been added"
      success = false
    end

    vcs_type     = @env.deploy_steps.find {|ds| ds.deploy_step_type_option.deploy_step_type.name == "vcs_type"}.deploy_step_type_option.name

    if 'svn' == vcs_type
      @rev_nums = Remoteserver::Svn.get_rev_nums(@env)
    elsif 'git' == vcs_type
      @rev_nums = Remoteserver::Git.get_rev_nums(@env)
    end

    if success
      respond_to do |format|
        format.html
        format.json
      end
    else
      respond_to do |format|
        format.html { redirect_to request.referer }
        format.json { render json: @env }
      end
    end

  end

  def create
    dof = DeployOptionForm.new(params[:deploy_option_form])

    environment = Environment.find(params[:id])

    environment.servers.each do |server|
      @deploy = Deploy.new(environment: environment, server: server)
      @deploy.user = current_user
      if !@deploy.save
        raise "Unable to save deploy"
      end

      if dof.revision_number
        doe = DeployOption.new
        doe.value = dof.revision_number
        doe.deploy_option_type = DeployOptionType.find_by name: :revision_number
        doe.deploy = @deploy
        doe.save
      end

      Resque.enqueue(Tasks::Deployment, environment.id, server.id, @deploy.id, true)
    end

    Remoteserver::DeployHooks.send_update @deploy, :pending

    respond_to do |format|
      format.html { redirect_to @deploy, :flash => { :alert => 'Deployment has been queued.' } }
      format.json { render @deploy, :location => @deploy}
    end
  end

  def update
    @deploy = Deploy.find(params[:id])

    if @deploy.update_attributes(status: :failed)
      Remoteserver::DeployHooks.send_update @deploy, :failed
      redirect_to :back, :flash => { :success => 'Deploy was failed.' }
    else
      redirect_to :back, :flash => { :error => 'Failed to fail the deploy.' }
    end
  end
end
