require "board"

describe Board do
  let(:board) { Board.new }

  describe "#move" do
    context "when request is valid" do
      it "moves a pawn forward" do
        board.move(0, 1, 0, 2)
        expect(board.spaces[2][0].piece).to eq("pawn")
      end
    end
  end
end