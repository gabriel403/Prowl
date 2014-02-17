class UsersController < ApplicationController
  def index
    @users = User.all
    respond_to do |format|
      format.html
      format.json
    end
  end

  def show
    @user = User.find(params[:id])
    respond_to do |format|
      format.html
      format.json
    end
  end

  def new
    @user = User.new
    respond_to do |format|
      format.html
      format.json
    end
  end

  def edit
    @user = User.find(params[:id])
    respond_to do |format|
      format.html
      format.json
    end
  end

  def create
    @user = User.new(user_params)

    if @user.save
      @user.password = @user.confirmation_token
      @user.save
      app_setup = AppSetup.find_by name: 'registrations_open'
      app_setup.value = 'false'
      app_setup.save

      flash[:notice] = "User was successfully created."
      respond_to do |format|
        format.html { redirect_to @user }
        format.json { render @user, :location => @user}
      end
    else
      render :action => 'new'
    end
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(user_params)
      sign_in @user, :bypass => true
      redirect_to @user, :flash => { :success => 'User was successfully updated.' }
    else
      render :action => 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path, :flash => { :success => 'User was successfully deleted.' }
  end

  private
  def user_params
    params.require(:user).permit(:username, :email, :password, :salt, :encrypted_password)
  end
end
