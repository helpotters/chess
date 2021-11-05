# frozen_string_literal: true

RSpec.describe ChessBoard do
  let(:game) { ChessBoard::Chess.new }
  it "has a version number" do
    expect(Chess::VERSION).not_to be nil
  end

  context "#input" do
    context "turn valid input into move:piece hash" do
      it "should only allow valid algebraic notation for pieces" do
        expect { input("K") }.not_to raise_error(ArgumentError)
        expect { input("J") }.to raise_error(ArgumentError)
      end
      it "should turn input into hash" do
        expect(input("N")).to eq({ piece: "N" })
      end
      it "should only allow one piece per entry" do
        expect { input("NN") }.to raise_error(Exception)
        expect { input(" ") }.to raise_error(Exception)
        expect { input("Knight") }.to raise_error(Exception)
      end
    end
  end

  context "create matrix" do
    it "should have all pieces in the starting locations" do
      expect(game.board("a2")).to eq("P")
    end
    # pending
    # it "should be objects belonging to black and white" do
    # end
    # it "should interpret alphanumeric chars into row(1..8):column(a..h)" do
    # end
  end
end
