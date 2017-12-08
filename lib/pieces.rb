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

    def move(x, y)
      if on_board?(x, y) && in_moveset?(x, y)
        @x = x
        @y = y
      end
      false
    end
  end

end