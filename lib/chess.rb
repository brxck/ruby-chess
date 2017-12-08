require_relative "board"
require "rainbow"

# Manages user input and game-flow
class Chess
  attr_accessor :player

  def initialize
    @board = Board.new
    @player = :white
  end

  def play
    loop do
      @board.draw
      x1, y1 = prompt("\n Move piece at ")
      x2, y2 = prompt("            to ")
      result = @board.move(x1, y1, x2, y2, @player)
      unless result.is_a?(Array)
        puts Rainbow("\n\n #{result}. Please try again.\n").red
        next
      end
      puts Rainbow("\n #{result[1]}\n").green
      @player = @player == :white ? :black : :white
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
    print text
    loop do
      input = gets.chomp.downcase
      break if validate(input)
      puts "Please try again. #{text}"
    end
    an_to_xy(input)
  end

  def validate(input)
    input.downcase!
    if ("a".."h").cover?(input[0]) && (1..8).cover?(input[1].to_i) && input.length == 2
      true
    else
      false
    end
  end
end
