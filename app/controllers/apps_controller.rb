class AppsController < ApplicationController
  def index
    @apps = App.all
  end

  def show
  end

  def new
    @app = App.new
  end

  def edit
    @app = App.find(params[:id])
  end

  def create
    @app = current_user.apps.create(params[:app].permit(:name, :description))
    redirect_to user_path(current_user)
  end

  def update
  end

  def destroy
  end
end
