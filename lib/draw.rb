# Draws the board to the terminal
module Draw
  def draw
    @bg_color = :khaki
    print_letters
    print "\n"
    each do |item, x, y|
      print_number(y) if x.zero?
      print_space(item)
      flip_color
      if x == 7
        print_number(y)
        print "\n"
        flip_color
      end
    end
    print_letters
    print "\n"
  end

  private

  def flip_color
    if @bg_color == :khaki
      @bg_color = :sienna
    elsif @bg_color == :sienna
      @bg_color = :khaki
    end
  end

  def print_letters
    print "   "
    ("a".."h").each { |letter| print " #{letter}  " }
  end

  def print_number(y)
    print " #{8 - y} "
  end

  def print_space(item)
    if item
      color = item.color == :white ? :snow : :black
      print Rainbow(" #{item.symbol}  ").color(color).bg(@bg_color)
    else
      print Rainbow("    ").bg(@bg_color)
    end
  end
end
