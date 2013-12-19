class ServersController < ApplicationController
  def index
    @user = current_user
    @servers = Server.all
  end

  def show
    @server = Server.find(params[:id])
  end

  def new
    @server = Server.new
    @authentication_types = AuthenticationType.all
  end

  def edit
    @server = Server.find(params[:id])
    @authentication_types = AuthenticationType.all
  end

  def create
    @server = Server.new(server_params)
    @server.user = current_user

    if @server.save
      redirect_to @server, :flash => { :success => 'Server was successfully created.' }
    else
      render :action => 'new'
    end
  end

  def update
    @server = Server.find(params[:id])

    if @server.update_attributes(server_params)
      redirect_to @server, :flash => { :success => 'Server was successfully updated.' }
    else
      render :action => 'edit'
    end
  end

  def destroy
    @server = Server.find(params[:id])
    @server.destroy
    redirect_to users_path, :flash => { :success => 'Server was successfully deleted.' }
  end

  private
  def server_params
    params.require(:server).permit(:name, :host, :authentication_type_id, :authentication, :username)
  end
end
