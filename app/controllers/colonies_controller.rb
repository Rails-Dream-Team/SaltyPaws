class ColoniesController < ApplicationController
  def index
    @colonies = Colony.all
    respond_to do |format|
      format.html
      format.json { render json: @colonies }
    end
  end

  def new
    @colony = Colony.new
  end

  def create
    @colony = Colony.new(colony_params)
    respond_to do |format|
      if @colony.save
        format.html { redirect_to colonies_path(@colony) }
        format.json { render json: {}, status: 201 }
      else
        format.html { render :new }
        format.json { render json: @colony.errors, status: 422 }
      end
    end
  end

  def show
    @colony = get_colony
    respond_to do |format|
      format.html
      format.json { render json: @colony }
    end
  end

  def edit
    @colony = get_colony
  end

  def update
    @colony = get_colony
    respond_to do |format|
      if @colony.update_attributes(colony_params)
        format.html { redirect_to colonies_path(@colony) }
      else
        format.html { render :edit }
      end
    end
  end

  private

  def colony_params
    params.require(:colony).permit(:name, :photo, :street_address, :city, :state, :zip_code, :enviroment, :pop, :vet)
  end

  def get_colony
    Colony.find(params[:id])
  end
end
