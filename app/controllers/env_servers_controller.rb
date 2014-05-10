class EnvServersController < ApplicationController
  load_and_authorize_resource

  # GET /env_servers
  # GET /env_servers.json
  def index
    @env_servers = EnvServer.all

    render json: @env_servers
  end

  # GET /env_servers/1
  # GET /env_servers/1.json
  def show
    @env_server = EnvServer.find(params[:id])

    render json: @env_server
  end

  # POST /env_servers
  # POST /env_servers.json
  def create
    @env_server = EnvServer.new(env_server_params)

    if @env_server.save
      render json: @env_server, status: :created, location: @env_server
    else
      render json: @env_server.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /env_servers/1
  # PATCH/PUT /env_servers/1.json
  def update
    @env_server = EnvServer.find(params[:id])

    if @env_server.update(env_server_params)
      head :no_content
    else
      render json: @env_server.errors, status: :unprocessable_entity
    end
  end

  # DELETE /env_servers/1
  # DELETE /env_servers/1.json
  def destroy
    @env_server = EnvServer.find(params[:id])
    @env_server.destroy

    head :no_content
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
  def env_server_params
    params.require(:env_server).permit(:env_id, :server_id)
  end
end
