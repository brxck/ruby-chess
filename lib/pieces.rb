module Pieces
  # Generic chess piece class
  class Piece
    attr_accessor :position, :color
    attr_reader :piece

    def initialize(x, y, color)
      @x = x
      @y = y
      @color = color
    end

    def on_board?(x, y)
      result = true
      [x, y].each { |coord| result = false unless (0..7).cover?(coord) }
      result
    end

    def in_moveset?(x, y)
      @move_set.include?([x - @x, y - @y]) ? true : false
    end

    def path_clear?(x, y)
      dx = @x
      dy = @y
      until [dx, dy] == [x, y]
        return false if @board.spaces[dx][dy]
        dx += dx <=> @x
        dy += dy <=> @y
      end
      true
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
    def symbol
      return "♙" if @color == :white
      return "♟" if @color == :black
    end

    # TODO: boardside check for attacked piece
    def initialize(x, y, color, start)
      super(x, y, color)
      if start == :top
        @move_set = [[1, -1], [0, -1], [-1, -1]]
      elsif start == :bottom
        @move_set = [[1, 1], [0, 1], [-1, 1]]
      end
    end
  end

  class Rook < Piece
    def symbol
      return "♖" if @color == :white
      return "♜" if @color == :black
    end

    def in_moveset?(x, y)
      if (x == @x && y != @y) || (x != @x && y == @y)
        return true if path_clear?(x, y)
      else
        false
      end
    end
  end

  class Bishop < Piece
    def symbol
      return "♗" if @color == :white
      return "♝" if @color == :black
    end

    def in_moveset?(x, y)
      if x - @x == y - @y
        return true if path_clear?(x, y)
      else
        false
      end
    end
  end

  class Knight < Piece
    def symbol
      return "♘" if @color == :white
      return "♞" if @color == :black
    end

    def initialize(x, y, color)
      super
      @move_set = [[2, 1], [2, -1], [-2, 1], [-2, -1],
                   [1, 2], [-1, 2], [1, -2], [-1, -2]]
    end
  end

  class King < Piece
    def symbol
      return "♔" if @color == :white
      return "♚" if @color == :black
    end

    def initialize(x, y, color)
      super
      @move_set = [[1, 0], [-1, 0], [0, 1], [0, -1],
                   [1, 1], [1, -1], [-1, 1], [-1, -1]]
    end
  end

  class Queen < Piece
    def symbol
      return "♕" if @color == :white
      return "♛" if @color == :black
    end

    # This just checks if we are moving in a straight line & if path is clear.
    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
    def in_moveset?(x, y)
      if (x == @x && y != @y) || (x != @x && y == @y) || x - @x == y - @y
        return true if path_clear?(x, y)
      else
        false
      end
    end
  end
end
