class AppsController < ApplicationController
  before_filter :authenticate_user!
  def index
    @apps = App.all
  end

  def show
    @app = App.find(params[:id])
  end

  def new
    @app = App.new
  end

  def edit
    @app = App.find(params[:id])
  end

  def create
    @app = App.new(app_params)

    if @app.save
      redirect_to @app, :flash => { :success => 'App was successfully created.' }
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
    redirect_to users_path, :flash => { :success => 'App was successfully deleted.' }
  end

  private
  def app_params
    params.require(:app).permit(:name, :description)
  end
end
