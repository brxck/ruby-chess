require "chess"

describe Chess do
  let(:chess) { described_class.new }

  describe "#validate" do
    it "accepts valid input" do
      expect(chess.validate("A4")).to eq(true)
    end

    it "rejects invalid input" do
      expect(chess.validate("5J")).to eq(false)
    end
  end

  describe "#an_to_xy" do
    it "converts AN to x, y coords" do
      expect(chess.an_to_xy("c4")).to eq([2, 4])
    end
  end
end
