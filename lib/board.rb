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

  def move(x1, y1, x2, y2, player)
    piece = space(x1, y1)
    return "There is no piece to move there" if piece.nil?
    return "You must move a #{player} piece" if piece.color != player
    return "Invalid move" unless piece.move(x2, y2)
    set_space(x2, y2, piece)
    set_space(x1, y1, nil)
    return true, "#{piece.piece.capitalize} to #{xy_to_an(x2, y2)}."
  end

  def xy_to_an(x, y)
    to_file = { 0 => "a", 1 => "b", 2 => "c", 3 => "d", 4 => "e", 5 => "f", 6 => "g", 7 => "h" }
    to_rank = { 7 => 1, 6 => 2, 5 => 3, 4 => 4, 3 => 5, 2 => 6, 1 => 7, 0 => 8 }

    return "#{to_file[x]}#{to_rank[y]}"
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
