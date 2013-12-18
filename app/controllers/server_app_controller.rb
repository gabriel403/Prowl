class ServerAppController < ApplicationController
  def link
    case params[:fromlocation]
    when 'app'
      @app = App.find(params[:id])
      @servers = Server.all
      render :action => 'fromapp'
    when 'server'
      @server = Server.find(params[:id])
      @apps = App.all
      render :action => 'fromserver'
    end
  end

  def linkcreate
    @app = App.find(params[:appid])
    @server = Server.find(params[:serverid])

    begin

      @app.servers << @server
      @server.apps << @app
    rescue Exception => e

      if e.is_a? ActiveRecord::RecordNotUnique
        redirect_to app_path(@app), :flash => { :warning => 'Server is already a target.' } and return
      end
    end

    redirect_to app_path(@app), :flash => { :success => 'Server added.' }
  end
end
