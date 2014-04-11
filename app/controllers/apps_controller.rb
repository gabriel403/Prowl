class AppsController < ApplicationController
  def index
    # logger.warn "About to combobulate the whizbang"
    @apps = App.all
    respond_to do |format|
      format.html
      format.json
    end
  end

  def show
    @allowremote = true
    @app = App.find(params[:id])
    @appid = @app.id
    respond_to do |format|
      format.html
      format.json
    end
  end

  def new
    @app = App.new
    respond_to do |format|
      format.html
      format.json
    end
  end

  def edit
    @app = App.find(params[:id])
    respond_to do |format|
      format.html
      format.json
    end
  end

  def create
    @app = App.new(app_params)
    @app.user = current_user

    if @app.save
      flash[:notice] = "App was successfully created."
      respond_to do |format|
        format.html { redirect_to @app }
        format.json { render @app }
      end
    else
      render :action => 'new'
    end
  end

  def update
    @app = App.find(params[:id])

    if @app.update_attributes(app_params)
      redirect_to @app, :flash => { :success => 'App was successfully updated.' }
    else
      render :action => 'edit'
    end
  end

  def destroy
    @app = App.find(params[:id])
    @app.destroy
    redirect_to apps_path, :flash => { :success => 'App was successfully deleted.' }
  end

  private
  def app_params
    params.require(:app).permit(:name, :description)
  end
end
