class Board < ApplicationRecord
  has_many :tiles, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true, format:{ with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  validates :total_mines, :width, :height, presence: true,
                                           numericality: { greater_than: 0, only_integer: true }
  validate :mines_less_than_board_area

  after_create :generate_minesweeper_board

  def as_array
    minesweeper_board = []
    ordered_tiles = tiles.order(:y, :x)
    ordered_tiles.each do |tile|
      minesweeper_board[tile.y] ||= []
      minesweeper_board[tile.y][tile.x] = tile.mine?
    end
    minesweeper_board
  end

  def self.ordered
    order(created_at: :desc)
  end

  private

  def mines_less_than_board_area
    errors.add(:total_mines, "must be less than total board area") unless total_mines < (width * height)
  end

  def generate_minesweeper_board
    mines_count = 0
    place_mines = []
    all_tiles = []

    total_mines.times do |mine|
      place_mines << [rand(width).to_i, rand(height).to_i]
    end

    height.times do |h|
      width.times do |w|
        is_mine = place_mines.include?([w, h]) && mines_count < total_mines
        mines_count += 1 if is_mine
        all_tiles << { x: w, y: h, mine: is_mine }
      end
    end
    self.tiles.insert_all(all_tiles)
  end
end
