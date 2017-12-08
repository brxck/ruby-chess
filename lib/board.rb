require "rainbow"
require_relative "pieces"

class Board
  include Pieces

  attr_accessor :spaces, :bg_color

  def initialize
    create_board
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

  def create_board
    @spaces = []
    @spaces << new_rank(0)
    @spaces << Array.new(8) { |x| Pawn.new(x, 1, :black) }
    4.times { @spaces << Array.new(8, nil) }
    @spaces << Array.new(8) { |x| Pawn.new(x, 6, :white) }
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

  # TODO: refactor
  def draw
    @bg_color = :khaki
    print_letters
    print "\n"
    each do |item, x, y|
      print_number(y) if x.zero?
      print_space(item)
      flip_color
      if x == 7
        print_number(y)
        print "\n"
        flip_color
      end
    end
    print_letters
    print "\n"
  end

  private

  def flip_color
    if @bg_color == :khaki
      @bg_color = :sienna
    elsif @bg_color == :sienna
      @bg_color = :khaki
    end
  end

  def print_letters
    print "   "
    ("a".."h").each { |letter| print " #{letter}  " }
  end

  def print_number(y)
    print " #{8 - y} "
  end

  def print_space(item)
    if item
      color = item.color == :white ? :snow : :black
      print Rainbow(" #{item.symbol}  ").color(color).bg(@bg_color)
    else
      print Rainbow("    ").bg(@bg_color)
    end
  end
end

board = Board.new
board.draw
