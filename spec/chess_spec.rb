# frozen_string_literal: true

include ChessBoard

RSpec.describe "#input" do
  let(:board) { ChessBoard::Chess.new }
  it "has a version number" do
    expect(Chess::VERSION).not_to be nil
  end

  context "notation" do
    context "turn valid input into move:piece hash" do
      it "should only allow valid algebraic notation for pieces" do
        expect { board.input("Ka2") }.not_to raise_error(NotationError)
        expect { board.input("Jh4") }.to raise_error(NotationError)
      end
      it "should turn input into hash" do
        expect(board.input("Nb4")).to include({ piece: "N" })
      end
      it "should only allow one piece per entry" do
        expect { board.input("NNc4") }.to raise_error(Exception)
        expect { board.input(" ") }.to raise_error(Exception)
        expect { board.input("Knight to j6") }.to raise_error(Exception)
      end
      it "should return both a piece and/or location hash" do
        location_hash = { piece: "N", location: ["a", 4] }
        expect(board.input("Na4")).to include(location_hash)
      end
    end
  end

  context "create matrix" do
    it "should have all pieces in the starting locations" do
      expect(board.board("a2")).to eq("P")
    end
    # pending
    # it "should be objects belonging to black and white" do
    # end
    # it "should interpret alphanumeric chars into row(1..8):column(a..h)" do
    # end
  end
end
