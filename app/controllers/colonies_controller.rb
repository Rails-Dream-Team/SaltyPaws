class ColoniesController < ApplicationController
  def index
    @colonies = Colony.all
    authorize @colonies
    respond_to do |format|
      format.html
      format.json { render json: @colonies }
    end
  end

  def new
    @colony = Colony.new
    authorize @colony
  end

  def create
    @colony = Colony.new(colony_params)
    authorize @colony
    respond_to do |format|
      if @colony.save
        format.html { redirect_to @colony }
        format.json { render json: {}, status: 201 }
      else
        format.html { render :new }
        format.json { render json: @colony.errors, status: 422 }
      end
    end
  end

  def show
    @colony = get_colony
    authorize @colony
    respond_to do |format|
      format.html
      format.json { render json: @colony }
    end
  end

  def edit
    @colony = get_colony
    authorize @colony
  end

  def update
    @colony = get_colony
    authorize @colony
    respond_to do |format|
      if @colony.update_attributes(colony_params)
        format.html { redirect_to @colony }
        format.json { render json: @colony, status: 202 }
      else
        format.html { render :edit }
        format.json { render json: @colony.errors, status: 422 }
      end
    end
  end

  def destroy
    @colony = get_colony
    authorize @colony
    @colony.destroy
    respond_to do |format|
      format.html { redirect_to colonies_path  }
      format.json { render json: {}, status: 200 }
    end
  end

  private

  def colony_params
    params.require(:colony).permit(:name, :photo, :street_address, :city, :state, :zip_code, :environment, :pop, :vet, :lat, :lng)
  end

  def get_colony
    Colony.find(params[:id])
  end
end
