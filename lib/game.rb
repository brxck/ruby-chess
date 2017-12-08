require "board"

class Game
  def initialize
    @board = Board.new
  end

  def prompt(text)
    puts text
    loop do
      input = gets.chomp.upcase
      break if validate(input)
      puts "Please try again. #{text}"
    end
    input.split("")
  end

  def validate(input)
    # Bending the rules for two characters
    # rubocop:disable Metrics/LineLength
    if ("A".."Z").cover?(input[0]) && (1..8).cover?(input[1]) && input.length == 2
      true
    else
      false
    end
  end
end