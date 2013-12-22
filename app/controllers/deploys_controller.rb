class DeploysController < ApplicationController
  require_dependency "tasks/deploy"
  require "resque"

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

    app.servers.each do |server|
      Resque.enqueue(Tasks::Deploy, app.id, server.id, true)
    end

    redirect_to deploy_path(deploy), :flash => { :alert => 'Deployment has been queued.' }
  end
end
