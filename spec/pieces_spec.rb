require "pieces"

describe Pieces do
  let(:pawn) { Pieces::Pawn.new(0, 0, :white, :bottom) }

  describe "#symbol" do
    context "when asked for white pawn" do
      it "returns white pawn symbol" do
        expect(pawn.symbol).to eq("♙")
      end
    end
  end
end
