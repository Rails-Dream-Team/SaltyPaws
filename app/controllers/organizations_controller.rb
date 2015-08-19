class OrganizationsController < ApplicationController

  def index
    @organizations = Organization.all
    respond_to do |format|
      format.html
      format.json { render json: @organizations }
    end
  end

  def new
    @organization = Organization.new
  end

  def create
    @organization = Organization.new(organization_params)
    respond_to do |format|
      if @organization.save
        format.html { redirect_to organizations_path(@organization) }
        format.json { render json: {}, status: 201 }
      else
        format.html { render :new }
        format.json { render json: @organization.errors, status: 422 }
      end
    end
  end

  def show
    @organization = get_organization
    respond_to do |format|
      format.html
      format.json {render json: @organization }
    end
  end

  def edit
    @organization = get_organization
  end

  def update
    @organization = get_organization
    respond_to do |format|
      if @organization.update_attributes(organization_params)
        format.html { redirect_to organizations_path(@organization) }
        format.json { render json: @organization, status: 202 }
      else
        format.html { render :edit }
        format.json { render json: @organization.errors, status: 422 }
      end
    end
  end

  def destroy
    @organization = get_organization
    @organization.destroy
    respond_to do |format|
      format.html { redirect_to organizations_path }
      format.json { render json: {}, status: 200 }
    end
  end

  private

  def organization_params
    params.require(:organization).permit(:name, :street_address, :city, :state, :zip_code, :description)
  end

  def get_organization
    Organization.find(params[:id])
  end

end
