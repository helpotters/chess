# frozen_string_literal: true

include ChessGame
include Pieces

RSpec.describe "#input" do
  let(:board) { ChessGame::Chess.new }
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
end

RSpec.describe "board" do
  let(:game_obj) { ChessGame::Chess.new }
  xcontext "board matrix should contain correct arrangement of pieces" do
    it "should create an 8x8 matrix" do
      matrix_var = game_obj.instance_variable_get(:board)
      expect(matrix_var.length).to eq(8)
      expect(matrix_var[0].length).to eq(8)
    end
    xit "should return the piece at position" do
      expect(game_obj.pos("d8")).to eq("R")
    end
  end
end

RSpec.describe Player do
  let(:player) { ChessGame::Player.new }
  context "create pieces" do
    # NOTE: Could remove dependence on Pieces by using mock responses
    subject(:player_pieces) { player.instance_variable_get(:@pieces).to_a }
    it { is_expected.to include(an_instance_of(Pawn)).exactly(8).times }
    it { is_expected.to include(an_instance_of(Bishop)).twice }
    it { is_expected.to include(an_instance_of(Knight)).twice }
    it { is_expected.to include(an_instance_of(Rook)).twice }
    it { is_expected.to include(an_instance_of(Queen)).once }
    it { is_expected.to include(an_instance_of(King)).once }
  end
  context "allow pieces to be removed or changed as a private function" do
    let(:game_engine) { ChessGame::Chess.new }
    it "should remove Pawn Object" do
    end
  end
  xcontext "input interprets string command and compares against @pieces" do
  end
  # TODO: change input to player so it can confirm valid pieces to move
end
