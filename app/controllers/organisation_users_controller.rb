class OrganisationUsersController < ApplicationController
  # GET /organisation_users
  # GET /organisation_users.json
  def index
    @organisation_users = OrganisationUser.all

    render json: @organisation_users
  end

  # GET /organisation_users/1
  # GET /organisation_users/1.json
  def show
    @organisation_user = OrganisationUser.find(params[:id])

    render json: @organisation_user
  end

  # POST /organisation_users
  # POST /organisation_users.json
  def create
    @organisation_user = OrganisationUser.new(params[:organisation_user])

    if @organisation_user.save
      render json: @organisation_user, status: :created, location: @organisation_user
    else
      render json: @organisation_user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /organisation_users/1
  # PATCH/PUT /organisation_users/1.json
  def update
    @organisation_user = OrganisationUser.find(params[:id])

    if @organisation_user.update(params[:organisation_user])
      head :no_content
    else
      render json: @organisation_user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /organisation_users/1
  # DELETE /organisation_users/1.json
  def destroy
    @organisation_user = OrganisationUser.find(params[:id])
    @organisation_user.destroy

    head :no_content
  end
end
