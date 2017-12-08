require_relative "pieces"

class Board
  include Pieces

  attr_accessor :spaces

  def initialize
    create_board
  end

  def create_board
    @spaces = []
    @spaces << new_rank(0)
    @spaces << Array.new { |x| Pawn.new(x, 0, :black) }
    4.times { @spaces << Array.new(8, nil)}
    @spaces << Array.new { |x| Pawn.new(x, 6, :black) }
    @spaces << new_rank(7)
  end

  def new_rank(y)
    color = y.zero? ? :black : :white
    [Rook.new(0, y, color),
     Knight.new(1, y, color),
     Bishop.new(2, y, color),
     King.new(3, y, color),
     Queen.new(4, y, color),
     Bishop.new(5, y, color),
     Knight.new(6, y, color),
     Rook.new(7, y, color)]
  end

  def each
    x = 0
    y = 0
    @spaces.each do |row|
      row.each do |item|
        yield(item, x, y)
        x += 1
      end
      y += 1
    end
  end
end
