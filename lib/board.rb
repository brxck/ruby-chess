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

  def draw
    @bg_color = :khaki

    each do |item, x, y|
      padding if x.zero?
      print_piece(item) unless item.nil?
      print_empty if item.nil?
      flip_color
      if x == 7
        print "\n"
        padding
        flip_color
      end
    end
  end

  private

  def flip_color
    if @bg_color == :khaki
      @bg_color = :sienna
    elsif @bg_color == :sienna
      @bg_color = :khaki
    end
  end

  def padding
    space = "      "
    8.times do
      print Rainbow(space).bg(@bg_color)
      @bg_color = flip_color
    end
    print "\n"
  end

  def print_empty
    space = "      "
    print Rainbow(space).bg(@bg_color)
  end

  def print_piece(item)
    occupied = "  #{item.symbol}   "
    color = item.color == :white ? :snow : :black
    print Rainbow(occupied).color(color).bg(@bg_color)
  end
end
