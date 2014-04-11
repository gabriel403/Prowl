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

    if success
      vcs_type     = @env.deploy_steps.find {|ds| ds.deploy_step_type_option.deploy_step_type.name == "vcs_type"}.deploy_step_type_option.name

      if 'svn' == vcs_type
        @rev_nums = Remoteserver::Svn.get_rev_nums(@env)
      elsif 'git' == vcs_type
        @rev_nums = Remoteserver::Git.get_branch_names(@env)
      end
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

      dof.instance_variables.each do |var_sym|
        dof_var = dof.instance_variable_get(var_sym)
        var_sym = var_sym.to_s.slice(1..-1).to_sym

        if :revision_number == var_sym
          if dof_var.split.length > 1
            doe                    = DeployOption.new
            doe.value              = dof_var.split[0]
            doe.deploy_option_type = DeployOptionType.find_by name: :revision_number
            doe.deploy             = @deploy
            doe.save

            doe                    = DeployOption.new
            doe.value              = dof_var.split[1]
            doe.deploy_option_type = DeployOptionType.find_by name: :branch_name
            doe.deploy             = @deploy
            doe.save
            next
          end
        end

        doe = DeployOption.new
        doe.value = dof_var
        doe.deploy_option_type = DeployOptionType.find_by name: var_sym
        doe.deploy = @deploy
        doe.save
      end


      # if dof.revision_number
      #   doe = DeployOption.new
      #   doe.value = dof.revision_number
      #   doe.deploy_option_type = DeployOptionType.find_by name: :revision_number
      #   doe.deploy = @deploy
      #   doe.save
      # end

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
