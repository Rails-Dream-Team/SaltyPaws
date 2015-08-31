class BoardsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    if current_user
      @boards = Board.all
    else
      @boards = Board.where(public: true)
    end
    authorize @boards
    respond_to do |format|
      format.html { render :index }
      format.json { render json: @boards }
    end
  end

  def new
    @board = Board.new
    authorize @board
  end

  def create
    @board= Board.new(board_params)
    authorize @board
    if @board.save
      redirect_to @board
    else
      render :new
    end
  end

  def show
    @board = get_board
    authorize @board
    respond_to do |format|
      format.html { render :show }
      format.json { render json: @board }
    end
  end

  def edit
    @board = get_board
    authorize @board
  end

  def update
    @board = get_board
    authorize @board
    if @board.update_attributes(board_params)
      redirect_to @board
    else
      render :edit
    end
  end

  def destroy
    @board = get_board
    authorize @board
    @board.destroy
    redirect_to boards_path
  end

  private

  def board_params
    params.require(:board).permit(:title)
  end

  def get_board
    Board.find(params[:id])
  end
end
