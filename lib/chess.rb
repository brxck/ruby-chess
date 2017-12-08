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
      print_message(result, x2, y2)
      next if result != true
      @player = @player == :white ? :black : :white
    end
  end

  # Just a case statement.
  # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
  def print_message(code, x2, y2)
    text = case code
           when :no_piece
             Rainbow("There is no piece to move there. Try again.").red
           when :wrong_piece
             Rainbow("You must move a #{@player} piece. Try again.").red
           when :invalid
             Rainbow("You can't move there. Try again.").red
           when true
             Rainbow("#{@board.space(x2, y2).piece.capitalize} to " \
                     "#{xy_to_an(x2, y2)}.").green
           end
    puts "\n\n " + text + "\n"
  end

  def xy_to_an(x, y)
    to_file = { 0 => "a", 1 => "b", 2 => "c", 3 => "d", 4 => "e", 5 => "f", 6 => "g", 7 => "h" }
    to_rank = { 7 => 1, 6 => 2, 5 => 3, 4 => 4, 3 => 5, 2 => 6, 1 => 7, 0 => 8 }

    "#{to_file[x]}#{to_rank[y]}"
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
