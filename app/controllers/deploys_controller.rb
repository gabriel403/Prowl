class DeploysController < ApplicationController
  require_dependency "remoteserver/git"
  def index
    @app = App.find(params[:id])
  end

  def show
    @deploy = Deploy.find(params[:id])
  end


  def new
    app = App.find(params[:id])

    deploy = Deploy.new(app: app)
    if !deploy.save
      raise "Unable to save deploy"
    end

    git = Remoteserver::Git.new

    app.servers.each do |server|
      @success, @returnval = git.deploy(app, server, true)
    end

    deploy.update_attributes(:status => (@success ? 'Finished' : 'Failed'), :output => @returnval.to_s)

    if @success
      redirect_to deploy_path(deploy), :flash => { :success => 'Deployment succeded.' }
    else
      redirect_to deploy_path(deploy), :flash => { :alert => 'Deployment failed, see below for details.' }
    end
  end
end
