class ServersController < ApplicationController
  def index
    @user = current_user
    @servers = Server.all
    respond_to do |format|
      format.html
      format.json
    end
  end

  def show
    @server = Server.find(params[:id])
    respond_to do |format|
      format.html
      format.json
    end
  end

  def new
    @server = Server.new
    @authentication_types = AuthenticationType.all
    respond_to do |format|
      format.html
      format.json
    end
  end

  def edit
    @server = Server.find(params[:id])
    @authentication_types = AuthenticationType.all
    respond_to do |format|
      format.html
      format.json
    end
  end

  def create
    @server = Server.new(server_params)
    @server.user = current_user

    if @server.save
      flash[:notice] = "Server was successfully created."
      respond_to do |format|
        format.html { redirect_to @server }
        format.json { render @server, :location => @server}
      end
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
    params.require(:server).permit(:name, :host, :authentication_type_id, :authentication, :username, :can_sudo, :sudo_password)
  end
end
