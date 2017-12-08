require "board"

describe Board do
  let(:board) { described_class.new }
  let(:blank) do
    board = described_class.new
    board.spaces = []
    8.times { board.spaces << Array.new(8, nil)  }
    board
  end

  describe "#move" do
    context "when moving pawn," do
      it "moves one space forward" do
        board.move(0, 1, 0, 2, :black)
        expect(board.space(0, 2).piece).to eq("black pawn")
      end

      it "allows two space move on first turn" do
        board.move(0, 1, 0, 3, :black)
        expect(board.space(0, 3).piece).to eq("black pawn")
      end

      it "disallows two spaces move after first turn" do
        board.move(0, 1, 0, 2, :black)
        board.move(0, 2, 0, 4, :black)
        expect(board.space(0, 2).piece).to eq("black pawn")
      end
    end

    context "when attacking with pawn," do
      before do
        victim = instance_double("Pawn", color: :white, piece: "white pawn")
        ally = instance_double("Pawn", color: :white, piece: "white pawn")
        board.set_space(1, 2, victim)
        board.set_space(1, 5, ally)
      end

      it "allows diagonal attacks" do
        board.move(0, 1, 1, 2, :black)
        expect(board.space(1, 2).piece).to eq("black pawn")
      end

      it "disallows head-on attack" do
        board.move(1, 1, 1, 2, :black)
        expect(board.space(1, 2).piece).to eq("white pawn")
      end

      it "disallows attack on own color" do
        board.move(0, 6, 1, 5, :white)
        expect(board.space(0, 6).piece).to eq("white pawn")
      end

      it "disallows attack on empty space" do
        board.move(3, 6, 4, 5, :white)
        expect(board.space(4, 4)).to eq(nil)
      end
    end
  end

  context "when moving bishop," do
    before do
      blank.set_space(2, 7, Pieces::Bishop.new(2, 7, :white, blank))
    end

    it "allows diagonal move" do
      expect(blank.move(2, 7, 4, 5, :white)).to eq(true)
    end
  end

  context "when moving rook," do
    before do
      blank.set_space(3, 3, Pieces::Rook.new(3, 3, :white, blank))
    end

    it "allows move to right" do
      expect(blank.move(3, 3, 4, 3, :white)).to eq(true)
    end
  end
end
