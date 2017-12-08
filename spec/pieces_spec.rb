require "pieces"

describe Pieces do
  let(:pawn) { Pieces::Pawn.new(0, 0, :white, []) }

  describe "#symbol" do
    it "returns unicode symbol" do
      expect(pawn.symbol).to eq("♟")
    end
  end
end
