# frozen_string_literal: true

RSpec.describe ChessBoard do
  let(:board) { ChessBoard::Chess.new }
  it "has a version number" do
    expect(Chess::VERSION).not_to be nil
  end

  context "#input" do
    context "turn valid input into move:piece hash" do
      it "should only allow valid algebraic notation for pieces" do
        expect { board.input("K") }.not_to raise_error(ArgumentError)
        expect { board.input("J") }.to raise_error(ArgumentError)
      end
      it "should turn input into hash" do
        expect(board.input("N")).to eq({ piece: "N" })
      end
      it "should only allow one piece per entry" do
        expect { board.input("NN") }.to raise_error(Exception)
        expect { board.input(" ") }.to raise_error(Exception)
        expect { board.input("Knight") }.to raise_error(Exception)
      end
    end
  end
end
