class DeploysController < ApplicationController
  require_dependency "tasks/deployment"
  require "resque"
  require "remoteserver/deploy_hooks"

  def index
    @app = App.find(params[:id])
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
    @app = App.find(params[:id])
    success = true

    if @app.deploy_steps.none? {|ds| ds.deploy_step_type_option.deploy_step_type.name == "destination"}
      flash_message :alert, "No destination deploy_step has been set"
      success = false
      # redirect_to request.referer
    end

    if @app.deploy_steps.none? {|ds| ds.deploy_step_type_option.deploy_step_type.name == "vcs_type"}
      flash_message :alert, "No vcs (git,svn) deploy_step has been set"
      success = false
    end

    if @app.deploy_steps.none? {|ds| ds.deploy_step_type_option.deploy_step_type.name == "deploy_method"}
      flash_message :alert, "No deploy method (pull,clone,export) deploy_step has been set"
      success = false
    end

    if @app.servers.count == 0
      flash_message :alert, "No servers have been added"
      success = false
    end

    vcs_type     = @app.deploy_steps.find {|ds| ds.deploy_step_type_option.deploy_step_type.name == "vcs_type"}.deploy_step_type_option.name

    if 'svn' == vcs_type
      vcs_location = @app.deploy_steps.find {|ds| ds.deploy_step_type_option.deploy_step_type.name == "vcs_location"}.value
      vcs_username = @app.deploy_steps.find {|ds| ds.deploy_step_type_option.name == "auth_username"}.value
      vcs_password = @app.deploy_steps.find {|ds| ds.deploy_step_type_option.name == "auth_value"}.value
      @vcs_conn_str = "svn log --username #{vcs_username} --password #{vcs_password} --limit 10 --no-auth-cache #{vcs_location}"
      @rev_nums = []
      revnums = `#{@vcs_conn_str}`
      revnums.split("\n").each {|ele| 
        rev_num = /r(?<rev_num>\d+)/.match(ele) 
        if rev_num
          @rev_nums << rev_num[:rev_num]
        end
      }
    end

    if success
      respond_to do |format|
        format.html
        format.json
      end
    else
      respond_to do |format|
        format.html { redirect_to request.referer }
        format.json { render json: @app }
      end
    end

  end

  def create
    dof = DeployOptionForm.new(params[:deploy_option_form])

    app = App.find(params[:id])

    app.servers.each do |server|
      @deploy = Deploy.new(app: app, server: server)
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

      Resque.enqueue(Tasks::Deployment, app.id, server.id, @deploy.id, true)
    end

    deploy_hooks_ray = app.deploy_steps.find_all {|ds| ds.deploy_step_type_option.deploy_step_type.name == "deploy_hook"}
    if deploy_hooks_ray
      Remoteserver::DeployHooks.send_update deploy_hooks_ray, @deploy, :pending
    end


    respond_to do |format|
      format.html { redirect_to @deploy, :flash => { :alert => 'Deployment has been queued.' } }
      format.json { render @deploy, :location => @deploy}
    end
  end

  def update
    @deploy = Deploy.find(params[:id])

    if @deploy.update_attributes(status: :failed)
      redirect_to :back, :flash => { :success => 'Deploy was failed.' }
    else
      redirect_to :back, :flash => { :success => 'Failed to fail the deploy.' }
    end
  end
end
