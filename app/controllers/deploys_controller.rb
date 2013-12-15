class DeploysController < ApplicationController
  require_dependency "remoteserver/git"

  def index
    @app = App.find(params[:id])
  end

  def show
    @deploy = Deploy.find(params[:id])
  end


  def new
    @app = App.find(params[:id])
    git = Remoteserver::Git.new
    @success, @returnval = git.deploy(true)

    @deploy = Deploy.new(success: @success, output: @returnval.to_s, app: @app)

    if @deploy.save
      if @success
        redirect_to deploy_path(@deploy), :flash => { :success => 'Deployment succeded.' }
      else
        redirect_to deploy_path(@deploy), :flash => { :alert => 'Deployment failed, see below for details.' }
      end
    else
      if @success
        redirect_to deploys_path(@app), :flash => { :success => 'Deployment succeded, failed to save.' }
      else
        redirect_to deploys_path(@app), :flash => { :alert => 'Deployment failed, see below for details, failed to save.' }
      end
    end

  end
end
