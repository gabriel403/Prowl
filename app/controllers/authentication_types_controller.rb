class AuthenticationTypesController < ApplicationController
  # GET /authentication_types
  # GET /authentication_types.json
  def index
    @authentication_types = AuthenticationType.all

    render json: @authentication_types
  end

  # GET /authentication_types/1
  # GET /authentication_types/1.json
  def show
    @authentication_type = AuthenticationType.find(params[:id])

    render json: @authentication_type
  end

  # POST /authentication_types
  # POST /authentication_types.json
  def create
    @authentication_type = AuthenticationType.new(params[:authentication_type])

    if @authentication_type.save
      render json: @authentication_type, status: :created, location: @authentication_type
    else
      render json: @authentication_type.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /authentication_types/1
  # PATCH/PUT /authentication_types/1.json
  def update
    @authentication_type = AuthenticationType.find(params[:id])

    if @authentication_type.update(params[:authentication_type])
      head :no_content
    else
      render json: @authentication_type.errors, status: :unprocessable_entity
    end
  end

  # DELETE /authentication_types/1
  # DELETE /authentication_types/1.json
  def destroy
    @authentication_type = AuthenticationType.find(params[:id])
    @authentication_type.destroy

    head :no_content
  end
end
