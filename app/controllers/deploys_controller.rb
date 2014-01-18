class DeploysController < ApplicationController
  require_dependency "tasks/deployment"
  require "resque"

  def index
    @app = App.find(params[:id])
  end

  def show
    @deploy = Deploy.find(params[:id])
  end

  def new
    @deploy_option_form = DeployOptionForm.new
    @app = App.find(params[:id])

    if @app.deploy_steps.none? {|ds| ds.deploy_step_type_option.deploy_step_type.name == "destination"}
      flash_message :alert, "No destination deploy_step has been set"
      redirect_to request.referer
    end

    if @app.deploy_steps.none? {|ds| ds.deploy_step_type_option.deploy_step_type.name == "vcs_type"}
      flash_message :alert, "No vcs (git,svn) deploy_step has been set"
      redirect_to request.referer
    end

    if @app.deploy_steps.none? {|ds| ds.deploy_step_type_option.deploy_step_type.name == "deploy_method"}
      flash_message :alert, "No deploy method (pull,clone,export) deploy_step has been set"
      redirect_to request.referer
    end

    if @app.servers.count == 0
      flash_message :alert, "No servers have been added"
      redirect_to request.referer
    end

    vcs_location = @app.deploy_steps.find {|ds| ds.deploy_step_type_option.deploy_step_type.name == "vcs_location"}.value
    vcs_username = @app.deploy_steps.find {|ds| ds.deploy_step_type_option.name == "auth_username"}.value
    vcs_password = @app.deploy_steps.find {|ds| ds.deploy_step_type_option.name == "auth_value"}.value
    @vcs_conn_str = "svn log --username #{vcs_username} --password #{vcs_password} --limit 4 --no-auth-cache #{vcs_location}"
    @revnums = `#{@vcs_conn_str}`
  end

  def create
    dof = DeployOptionForm.new(params[:deploy_option_form])
    if dof.revision_number
      doe = DeployOption.new
      doe.value = dof.revision_number
      doe.deploy_option_type = DeployOptionType.find_by name: :revision_number
    end

    app = App.find(params[:id])

    app.servers.each do |server|
      @deploy = Deploy.new(app: app, server: server)
      if !@deploy.save
        raise "Unable to save deploy"
      end
      doe.deploy = @deploy
      doe.save

      Resque.enqueue(Tasks::Deployment, app.id, server.id, @deploy.id, true)
    end

    redirect_to @deploy, :flash => { :alert => 'Deployment has been queued.' }
  end
end
