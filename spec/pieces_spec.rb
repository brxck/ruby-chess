require "pieces"
require "board"

describe Pieces::Pawn do
  let(:board) { Board.new }
  let(:pawn) { described_class.new(0, 1, :black, board) }

  describe "#symbol" do
    it "returns unicode symbol" do
      expect(pawn.symbol).to eq("♟")
    end
  end

  describe "#in_moveset?" do
    it "returns true for valid move" do
      expect(pawn.in_moveset?(0, 2)).to eq(true)
    end

    it "returns false for an invalid move" do
      expect(pawn.in_moveset?(0, 5)).to eq(false)
    end
  end

  describe "#on_board?" do
    it "returns true for valid coords" do
      expect(pawn.on_board?(5, 5)).to eq(true)
    end

    it "returns false for invalid coords" do
      expect(pawn.on_board?(12, 0)).to eq(false)
    end
  end

  describe "#takeable?" do
    it "returns true for empty spaces" do
      expect(pawn.takeable?(0, 2)).to eq(true)
    end

    it "returns true for opposite color pieces" do
      expect(pawn.takeable?(0, 6)).to eq(true)
    end

    it "returns false for same-colored pieces" do
      expect(pawn.takeable?(2, 1)).to eq(false)
    end
  end
end
