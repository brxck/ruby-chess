module Pieces
  # Generic chess piece class
  class Piece
    attr_accessor :position

    def initialize(x, y)
      @x = x
      @y = y
    end

    def on_board?(x, y)
      result = true
      [x, y].each { |coord| result = false unless (0..7).cover?(coord) }
      result
    end
  end
end