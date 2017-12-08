require "rainbow"
require_relative "pieces"
require_relative "draw"

# Game board class.
# @spaces is indexed like @spaces[y][x] !!!
class Board
  include Pieces
  include Draw

  attr_accessor :spaces, :bg_color

  def initialize
    create_board
  end

  def move(x1, y1, x2, y2)
    piece = @spaces[y1][x1]
    return false unless piece.move(x2, y2)
    @spaces[y2][x2] = piece
  end

  def an_to_xy(an)
    to_x = { a: 0, b: 1, c: 2, d: 3, e: 4, f: 5, g: 6, h: 7 }
    to_y = { 1 => 7, 2 => 6, 3 => 5, 4 => 4, 5 => 3, 6 => 2, 7 => 1, 8 => 0 }

    x, y = an.split("")
    [to_x[x.to_sym], to_y[y.to_i]]
  end

  def new_rank(y)
    color = y.zero? ? :black : :white
    [Rook.new(0, y, color, @spaces),
     Knight.new(1, y, color, @spaces),
     Bishop.new(2, y, color, @spaces),
     King.new(3, y, color, @spaces),
     Queen.new(4, y, color, @spaces),
     Bishop.new(5, y, color, @spaces),
     Knight.new(6, y, color, @spaces),
     Rook.new(7, y, color, @spaces)]
  end

  def create_board
    @spaces = []
    @spaces << new_rank(0)
    @spaces << Array.new(8) { |x| Pawn.new(x, 1, :black, @spaces) }
    4.times { @spaces << Array.new(8, nil) }
    @spaces << Array.new(8) { |x| Pawn.new(x, 6, :white, @spaces) }
    @spaces << new_rank(7)
  end

  def each
    y = 0
    @spaces.each do |row|
      x = 0
      row.each do |item|
        yield(item, x, y)
        x += 1
      end
      y += 1
    end
  end
end

board = Board.new
board.draw
