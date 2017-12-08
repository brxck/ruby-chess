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
    input
  end

  def validate(input)
    if ("A".."Z").cover?(input[0]) && (1..8).cover?(input[1])
      true
    else
      false
    end
  end
end