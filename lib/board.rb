class Board
  attr_accessor :spaces

  def initialize
    @spaces = []
    @spaces << Array.new(8, nil)
  end

  def each
    @spaces.each do |row|
      row.each do |item|
        yield item
      end
    end
  end
end
