class CatsController < ApplicationController
  def index
    @cats = Cat.all
    respond_to do |format|
      format.html
      format.json { render json: @cats }
    end
  end

  def new
    @cat = Cat.new
  end

  def create
    @cat = Cat.new(cat_params)
    respond_to do |format|
      if @cat.save
        format.html { redirect_to cats_path(@cat) }
        format.json { render json: {}, status: 201 }
      else
        format.html { render :new }
        format.json { render json: @cat.errors, status: 422 }
      end
    end
  end

  def show
    @cat = get_cat
    respond_to do |format|
      format.html
      format.json { render json: @cat }
    end
  end

  def edit
    @cat = get_cat
  end

  def update
    @cat = get_cat
    respond_to do |format|
      if @cat.update_attributes(cat_params)
        format.html { redirect_to cats_path(@cat) }
        format.json { render json: @cat, status: 202 }
      else
        format.html { render :edit }
        format.json { render json: @cat.errors, status: 422 }
      end
    end
  end

  def destroy
    @cat = get_cat
    @cat.destroy
    respond_to do |format|
      format.html { redirect_to cats_path  }
      format.json { render json: {}, status: 200 }
    end
  end

  private

  def cat_params
    params.require(:cat).permit(:name, :description, :sex, :age, :date_trapped, :altered, :eartipped, :rabies_tag, :distemper, :microchip, :photo)
  end

  def get_cat
    Cat.find(params[:id])
  end
end
