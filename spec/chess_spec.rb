# frozen_string_literal: true

include ChessGame
include Pieces

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
  context "input interprets string command and compares against @pieces" do
    let(:player) { ChessGame::Player.new }
    context "notation" do
      context "turn valid input into move:piece hash" do
        it "should only allow valid algebraic notation for pieces" do
          expect { player.input("Ka2") }.not_to raise_error(NotationError)
          expect { player.input("Jh4") }.to raise_error(NotationError)
        end
        it "should turn input into hash" do
          expect(player.input("Nb4")).to include({ piece: "N" })
        end
        it "should only allow one piece per entry" do
          expect { player.input("NNc4") }.to raise_error(Exception)
          expect { player.input(" ") }.to raise_error(Exception)
          expect { player.input("Knight to j6") }.to raise_error(Exception)
        end
        it "should return both a piece and/or location hash" do
          location_hash = { piece: "N", location: ["a", 4] }
          expect(player.input("Na4")).to include(location_hash)
        end
      end
    end
  end
end

RSpec.describe Board do
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

RSpec.describe Chess do
end
