require_relative "pieces"
require_relative "draw"

# Game board class.
# @spaces is indexed like @spaces[y][x], use Board#space(x, y) instead.
class Board
  include Pieces
  include Draw

  attr_accessor :spaces

  def initialize
    create_board
  end

  def move(x1, y1, x2, y2)
    piece = space(x1, y1)
    return false unless piece.move(x2, y2)
    set_space(x2, y2, piece)
    set_space(x1, y1, nil)
  end

  def space(x, y)
    return nil if @spaces[y].nil?
    @spaces[y][x]
  end

  def set_space(x, y, value)
    return nil if @spaces[y].nil?
    @spaces[y][x] = value
  end

  def new_rank(y)
    color = y.zero? ? :black : :white
    [Rook.new(0, y, color, self),
     Knight.new(1, y, color, self),
     Bishop.new(2, y, color, self),
     King.new(3, y, color, self),
     Queen.new(4, y, color, self),
     Bishop.new(5, y, color, self),
     Knight.new(6, y, color, self),
     Rook.new(7, y, color, self)]
  end

  def create_board
    @spaces = []
    @spaces << new_rank(0)
    @spaces << Array.new(8) { |x| Pawn.new(x, 1, :black, self) }
    4.times { @spaces << Array.new(8, nil) }
    @spaces << Array.new(8) { |x| Pawn.new(x, 6, :white, self) }
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
