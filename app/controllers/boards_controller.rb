class BoardsController < ApplicationController
  before_action :set_board, only: [:show]

  def show
    @tiles = @board.as_array
  end

  def index
    @boards = Board.all.ordered
  end

  def new
    @board = Board.new

    @recent_boards =  Board.ordered.limit(10)
  end

  def create
    @board = Board.new(board_params)

    respond_to do |format|
      if @board.save
        format.html { redirect_to @board, notice: "Board was successfully created." }
        format.json { render :show, status: :created, location: @board }
      else
        format.html { render :new, status: :unprocessable_entity, alert: "Unable to create board." }
        format.json { render json: @board.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def board_params
    params.require(:board).permit(:email, :name, :width, :height, :total_mines)
  end

  def set_board
    @board = Board.find(params[:id])
  end
end
