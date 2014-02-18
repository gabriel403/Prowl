class EnvironmentsController < ApplicationController
  before_action :set_environment, only: [:show, :edit, :update, :destroy]

  # GET /environments
  # GET /environments.json
  def index
    @environments = Environment.all
  end

  # GET /environments/1
  # GET /environments/1.json
  def show
    @app = @environment.app
  end

  # GET /environments/new
  def new
    @app         = App.find(params[:appid])
    @environment = Environment.new
    @url         = environments_path(@environment, :appid => @app.id)
    respond_to do |format|
      format.html
      format.json
    end
  end

  # GET /environments/1/edit
  def edit
    @url = environment_path(@environment)
    respond_to do |format|
      format.html
      format.json
    end
  end

  # POST /environments
  # POST /environments.json
  def create
    @app = App.find(params[:appid])
    @environment = Environment.new(environment_params)
    @environment.app = @app

    @server = Server.find(params[:environment][:servers])
    if @server
      @environment.servers << @server
    end

    # @app.environments << @environment

    respond_to do |format|
      if @environment.save
        # @app.environments << @environment
        @app.save
        flash[:notice] = 'Environment was successfully created.'
        format.html { redirect_to @environment }
        format.js { render action: 'show', status: :created, location: @environment }
      else
        flash[:error] = 'Failed to save environment.'
        format.html { render action: 'new' }
        format.js { render json: @environment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /environments/1
  # PATCH/PUT /environments/1.json
  def update
    respond_to do |format|
      if @environment.update(environment_params)
        flash[:notice] = 'Environment was successfully updated.'
        format.html { redirect_to @environment }
        format.json { head :no_content }
      else
        flash[:error] = 'Failed to save environment.'
        format.html { render action: 'edit' }
        format.json { render json: @environment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /environments/1
  # DELETE /environments/1.json
  def destroy
    @environment.destroy
    respond_to do |format|
      format.html { redirect_to environments_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_environment
      @environment = Environment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def environment_params
      params.require(:environment).permit(:name)
    end
end
