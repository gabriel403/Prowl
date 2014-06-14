class ServersController < ApplicationController
  load_and_authorize_resource

  # GET /servers
  # GET /servers.json
  def index
    @servers = current_user.servers

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
    @server = Server.new(server_params)

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

    if @server.update(server_params)
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

  private

    # Never trust parameters from the scary internet, only allow the white list through.
  def server_params
    params.require(:server).permit(:organisation_id, :name, :host, :port, :username, :authentication_type_id, :authentication, :enabled, :can_sudo, :sudo_password)
  end
end
