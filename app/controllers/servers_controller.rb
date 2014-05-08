class ServersController < ApplicationController
  load_and_authorize_resource

  # GET /servers
  # GET /servers.json
  def index
    @servers = Server.all

    render json: @servers
  end

  # GET /servers/1
  # GET /servers/1.json
  def show
    @server = Server.find(params[:id])

    render json: @server
  end

  # POST /servers
  # POST /servers.json
  def create
    @server = Server.new(params[:server])

    if @server.save
      render json: @server, status: :created, location: @server
    else
      render json: @server.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /servers/1
  # PATCH/PUT /servers/1.json
  def update
    @server = Server.find(params[:id])

    if @server.update(params[:server])
      head :no_content
    else
      render json: @server.errors, status: :unprocessable_entity
    end
  end

  # DELETE /servers/1
  # DELETE /servers/1.json
  def destroy
    @server = Server.find(params[:id])
    @server.destroy

    head :no_content
  end
end
