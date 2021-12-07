# frozen_string_literal: true

include ChessGame # Main
include Pieces

RSpec.describe Player do
  let(:player) { ChessGame::Player.new }
  # TODO: Improve the current brittleness of tests
  context "input interprets string command and compares against @pieces" do
    let(:player) { ChessGame::Player.new }
    context "notation" do
      context "turn valid input into move:piece hash" do
        it "should only allow valid algebraic notation for pieces" do
          expect { player.input("Ka2") }.not_to raise_error
          expect { player.input("Jh4") }.to raise_error(NotationError)
        end
        it "should turn input into hash" do
          expect(player.input("Nb4")).to include({ piece: "N" })
        end
        it "should only allow one piece per entry" do
          expect { player.input("NNc4") }.to raise_error(NotationError)
          expect { player.input(" ") }.to raise_error(NotationError)
          expect { player.input("Knight to j6") }.to raise_error(NotationError)
        end
        it "should return both a piece and/or location hash" do
          location_hash = { piece: "N", location: ["a", 4] }
          expect(player.input("Na4")).to include(location_hash)
        end
      end
    end
  end
end

RSpec.describe Game do
  subject(:game_obj) { Game.new }
  context "Create both players" do
    it "should create a player for White" do
      white = game_obj.instance_variable_get(:@white)
      expect(white).to be_an_instance_of(Player)
    end
    it "should create a player for Black" do
      black = game_obj.instance_variable_get(:@black)
      expect(black).to be_an_instance_of(Player)
    end
  end
  context "#play" do
    context "#place_piece" do
      before do
        board = double
        game_obj.instance_variable_set(:@board, board)
        allow(board).to receive(:request).and_return("bad input", "Nb1")
      end
      it "should receive a notation error with bad input" do
        allow(ChessGame::Player).to receive(:input).with("Nb1").and_return(NotationError)
        expect { game_obj.send(:place_piece, Player.new) }.to raise_error(NotationError)
      end
      it "should ask again if NotationError" do
        hash = { piece: "Knight", location: ["a", 1] }
        allow(ChessGame::Player).to receive(:input).with("Nb1").and_return(hash)
        expect { game_obj.send(:place_piece, Player.new) }.to raise_error(NotationError)
        expect { game_obj.send(:place_piece, Player.new) }.to_not raise_error(NotationError)
      end
    end
    xcontext "#checkmate?" do
    end
    xcontext "#legal?" do
      xit "should keep a King from going into check"
      xit "should ask the piece if it can move there"
    end
    xcontext "#capture?"
  end
end

RSpec.describe Board do
  let(:board_obj) { ChessGame::Game.new.instance_variable_get(:@board) }
  context "piece matrix instance variable" do
    it "should create an 8x8 matrix" do
      matrix_var = board_obj.instance_variable_get(:@board_matrix)
      expect(matrix_var.length).to eq(8)
      expect(matrix_var[0].length).to eq(8)
    end
  end
  context "#initialize" do
    # the board initializes piece positions
    context "should assign each a position on the board" do
      let(:board) { Board.new }
      let(:piece) { Piece.new("bishop") }
      let(:space) { board.board_matrix[0][2] } # White King-side Bishop
      it "should assign piece in unoccupied space" do
        # empty space available
        expect(space).to_not be(an_instance_of(Piece))
        # assign piece
        board.occupy([0, 2], piece)
        expect(board.board_matrix[0][2]).to eq(piece)
      end
      it "should not assign piece in occupied space" do
        new_piece = Piece.new("pawn")
        board.occupy([0, 2], piece)
        expect(space).to be_an_instance_of(Piece)
        # assign piece
        expect { board.occupy([0, 2], new_piece) }.to raise_error
      end
      xit "should assign piece in according to letter in matrix"
      xit "all pieces should be assigned a position"
    end
  end
  xcontext "#ask"
  xcontext "#display"
  xcontext "#update"
end
