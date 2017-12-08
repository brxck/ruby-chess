require_relative "board"

# Manages user input and game-flow
class Chess
  def initialize
    @board = Board.new
  end

  def play
    loop do
      @board.draw
      x1, y1 = prompt("Piece to move:")
      x2, y2 = prompt("Target location:")
      @board.move(x1, y1, x2, y2)
    end
  end

  def an_to_xy(an)
    to_x = { a: 0, b: 1, c: 2, d: 3, e: 4, f: 5, g: 6, h: 7 }
    to_y = { 1 => 7, 2 => 6, 3 => 5, 4 => 4, 5 => 3, 6 => 2, 7 => 1, 8 => 0 }

    x, y = an.split("")
    [to_x[x.to_sym], to_y[y.to_i]]
  end

  def prompt(text)
    input = nil
    puts text
    loop do
      input = gets.chomp.downcase
      break if validate(input)
      puts "Please try again. #{text}"
    end
    an_to_xy(input)
  end

  def validate(input)
    # Bending the rules for two characters
    # rubocop:disable Metrics/LineLength
    input.downcase!
    if ("a".."z").cover?(input[0]) && (1..8).cover?(input[1].to_i) && input.length == 2
      true
    else
      false
    end
  end
end