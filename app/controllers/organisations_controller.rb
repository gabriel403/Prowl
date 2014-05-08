class OrganisationsController < ApplicationController
  # GET /organisations
  # GET /organisations.json
  def index
    @organisations = Organisation.all

    render json: @organisations
  end

  # GET /organisations/1
  # GET /organisations/1.json
  def show
    @organisation = Organisation.find(params[:id])

    render json: @organisation
  end

  # POST /organisations
  # POST /organisations.json
  def create
    @organisation = Organisation.new(params[:organisation])

    if @organisation.save
      render json: @organisation, status: :created, location: @organisation
    else
      render json: @organisation.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /organisations/1
  # PATCH/PUT /organisations/1.json
  def update
    @organisation = Organisation.find(params[:id])

    if @organisation.update(params[:organisation])
      head :no_content
    else
      render json: @organisation.errors, status: :unprocessable_entity
    end
  end

  # DELETE /organisations/1
  # DELETE /organisations/1.json
  def destroy
    @organisation = Organisation.find(params[:id])
    @organisation.destroy

    head :no_content
  end
end
