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

    def in_moveset?(x, y)
      @move_set.include?([x - @x, y - @y]) ? true : false
    end

    def move(x, y)
      if on_board?(x, y) && in_moveset?(x, y)
        @x = x
        @y = y
      end
      false
    end
  end

  # Self documenting code ftw.
  # rubocop:disable Style/Documentation

  class Pawn < Piece
    # TODO: boardside check for attacked piece
    def initialize(start)
      if start == :top
        @move_set = [[1, -1], [0, -1], [-1, -1]]
      elsif start == :bottom
        @move_set = [[1, 1], [0, 1], [-1, 1]]
      end
    end
  end

  class Rook < Piece
    def in_moveset?(x, y)
      if x == @x && y != @y
        true
      elsif x != @x && y == @y
        true
      else
        false
      end
    end
  end

  class Bishop < Piece
    def in_moveset?(x, y)
      return true if x - @x == y - @y
      false
    end
  end

  class Knight < Piece
    @move_set = [[2, 1], [2, -1], [-2, 1], [-2, -1],
                 [1, 2], [-1, 2], [1, -2], [-1, -2]]
  end

  class King < Piece
    @move_set = [[1, 0], [-1, 0], [0, 1], [0, -1],
                 [1, 1], [1, -1], [-1, 1], [-1, -1]]
  end
end
