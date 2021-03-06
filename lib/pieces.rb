module Pieces
  # Generic chess piece class
  class Piece
    attr_accessor :position
    attr_reader :piece, :symbol, :color, :move_set

    def initialize(x, y, color, board)
      @x = x
      @y = y

      @color = color
      @piece = "#{color} #{self.class.name[8..-1].downcase}"

      @board = board
      @board.pieces << self
    end

    def on_board?(x, y)
      result = true
      [x, y].each { |coord| result = false unless (0..7).cover?(coord) }
      result
    end

    def in_moveset?(x, y)
      @move_set.include?([x - @x, y - @y])
    end

    def path_clear?(x, y)
      dx = @x + (x <=> @x)
      dy = @y + (y <=> @y)
      until [dx, dy] == [x, y]
        return false if @board.space(dx, dy)
        dx += x <=> dx
        dy += y <=> dy
      end
      true
    end

    def takeable?(x, y)
      if @board.space(x, y).nil?
        true
      elsif @board.space(x, y).color == @color
        false
      else
        @board.space(x, y).color
      end
    end

    def move(x, y)
      if on_board?(x, y) && in_moveset?(x, y) && takeable?(x, y)
        @x = x
        @y = y
        true
      else
        false
      end
    end

    def check?
      (0..7).each do |x|
        (0..7).each do |y|
          return true if in_moveset?(x, y) && @board.space(x, y).is_a?(King) &&
                         @board.space(x, y).color != @color
        end
      end
      false
    end

    def inspect
      @piece
    end
  end

  # Self documenting code ftw.
  # rubocop:disable Style/Documentation

  class Pawn < Piece
    # TODO: boardside check for attacked piece
    # TODO
    def initialize(x, y, color, board)
      super
      @first_move = true
      @symbol = "♟"
      if y == 1
        @move_set = [[0, 1], [0, 2]]
        @attack_set = [[1, 1], [-1, 1]]
      elsif y == 6
        @move_set = [[0, -1], [0, -2]]
        @attack_set = [[1, -1], [-1, -1]]
      end
    end

    def in_attackset?(x, y)
      @attack_set.include?([x - @x, y - @y])
    end

    def first_move
      return nil unless @first_move == true
      move_set.pop
      @first_move = false
    end

    def move(x, y)
      if in_attackset?(x, y)
        return false unless on_board?(x, y) &&
                            %i[white black].include?(takeable?(x, y))
      elsif in_moveset?(x, y)
        return false unless on_board?(x, y) && takeable?(x, y) == true
      else
        return false
      end
      @x = x
      @y = y
      first_move
      true
    end
  end

  class Rook < Piece
    def initialize(x, y, color, board)
      super
      @symbol = "♜"
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
    def initialize(x, y, color, board)
      super
      @symbol = "♝"
    end

    def in_moveset?(x, y)
      if (x - @x).abs == (y - @y).abs
        return true if path_clear?(x, y)
      else
        false
      end
    end
  end

  class Knight < Piece
    def initialize(x, y, color, board)
      super
      @symbol = "♞"
      @move_set = [[2, 1], [2, -1], [-2, 1], [-2, -1],
                   [1, 2], [-1, 2], [1, -2], [-1, -2]]
    end
  end

  class King < Piece
    def initialize(x, y, color, board)
      super
      @symbol = "♚"
      @move_set = [[1, 0], [-1, 0], [0, 1], [0, -1],
                   [1, 1], [1, -1], [-1, 1], [-1, -1]]
    end
  end

  class Queen < Piece
    def initialize(x, y, color, board)
      super
      @symbol = "♛"
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
