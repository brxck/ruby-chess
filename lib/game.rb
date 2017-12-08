require "board"

# Manages user input and game-flow
class Game
  def initialize
    @board = Board.new
  end

  def an_to_xy(an)
    to_x = { a: 0, b: 1, c: 2, d: 3, e: 4, f: 5, g: 6, h: 7 }
    to_y = { 1 => 7, 2 => 6, 3 => 5, 4 => 4, 5 => 3, 6 => 2, 7 => 1, 8 => 0 }

    x, y = an.split("")
    [to_x[x.to_sym], to_y[y.to_i]]
  end

  def prompt(text)
    puts text
    loop do
      input = gets.chomp.upcase
      break if validate(input)
      puts "Please try again. #{text}"
    end
    an_to_xy(input)
  end

  def validate(input)
    # Bending the rules for two characters
    # rubocop:disable Metrics/LineLength
    if ("A".."Z").cover?(input[0]) && (1..8).cover?(input[1].to_i) && input.length == 2
      true
    else
      false
    end
  end
end