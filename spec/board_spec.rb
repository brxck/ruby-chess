require "board"

describe Board do
  let(:board) { Board.new }

  describe "#move" do
    context "when moving pawn" do
      it "moves one space forward" do
        board.move(0,1, 0,2)
        expect(board.spaces[2][0].piece).to eq("black pawn")
      end

      it "allows two space move on first turn" do
        board.move(0,1, 0,3)
        expect(board.spaces[3][0].piece).to eq("black pawn")
      end

      it "disallows two spaces move after first turn" do
        board.move(0,1, 0,2)
        board.move(0,2, 0,4)
        expect(board.spaces[2][0].piece).to eq("black pawn")
      end
    end

    context "when attacking with pawn" do
      it "allows diagonal attacks" do
        victim = instance_double("Pawn", :color => :white)
        board.spaces[2][1] = victim
        board.move(0,1, 1,2)
        expect(board.spaces[2][1].piece).to eq("black pawn")
      end

      it "disallows head-on attack" do

      end

      it "disallows attack on own color" do

      end

      it "disallows attack on empty space" do

      end
    end
  end
end
