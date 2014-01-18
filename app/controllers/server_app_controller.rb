class ServerAppController < ApplicationController
  def link
    case params[:from_type]
    when 'app'
      @app = App.find(params[:id])
      @toents = Server.all
      session[:from_type] = 'app'
      session[:to_type]   = 'server'
    when 'server'
      @server = Server.find(params[:id])
      @toents = App.all
      session[:from_type] = 'server'
      session[:to_type]   = 'app'
    end
  end

  def linkcreate
    if session[:from_type] == 'server'
      @app = App.find(params[:to_id])
      @server = Server.find(params[:from_id])
    else
      @app = App.find(params[:from_id])
      @server = Server.find(params[:to_id])
    end


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
