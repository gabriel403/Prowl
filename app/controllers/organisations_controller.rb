class OrganisationsController < ApplicationController
  load_and_authorize_resource

  # GET /organisations
  # GET /organisations.json
  def index
    # @organisations = Organisation.accessible_by(current_ability)
    if params.has_key?('access_code')
      access_code = params['access_code']
      @organisations = Organisation.find_by access_code: access_code
    else
      @organisations = current_user.organisations
    end

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
    @organisation = Organisation.new(organisation_params)

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

    if @organisation.update(organisation_params)
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

  private

    # Never trust parameters from the scary internet, only allow the white list through.
  def organisation_params
    params.require(:organisation).permit(:name, :access_code)
  end
end
