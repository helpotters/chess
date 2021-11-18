# pieces_spec.rb

require_relative "./../lib/pieces"
include Pieces

RSpec.describe Pieces do
  context "Pawn" do
    let(:pawn) { Piece.new("pawn") } # a2
    it "should only travel one square" do
      valid_move = [0, 2] # a3
      expect(pawn.move(valid_move)).to eq(valid_move)
    end
    it "have choice to travel two columnar places in first move" do
      valid_move = [0, 3] # a4
      expect(pawn.move(valid_move)).to eq(valid_move)
      invalid_move = [0, 5] # a6
      expect { pawn.move(invalid_move) }.to raise_error(BadMove)
    end
    it "should have choice to capture diagonally" do
      capture = [1, 2]
      expect(pawn.move(capture)).to eq(capture)
    end
    # TODO: figure out legality checks
    xit "have choice for en passasnt in first move"
  end
  context "Knight" do
    starting_pos = [4, 4]
    let(:knight) { Piece.new("knight") }

    it "should move two blocks plus one block adjacent in any direction" do
      moves = all_valid_moves(starting_pos, [[2, 1], [1, 2]])
      valid_positive_move = [6, 5]
      expect(moves).to include(knight.move(valid_positive_move))
      valid_negative_move = [4, 2]
      expect { knight.move(valid_negative_move) }.to raise_error(BadMove)
    end
  end
  context "Bishop" do
    let(:bishop) { Piece.new("knight") }
    it "should move in any diagonal" do
      pattern = bishop.instance_variable_get(:@movement_pattern)
      moves = all_valid_moves([3, 3], pattern, true)

      valid_move = [8, 8]
      valid_operation = bishop.move(valid_move)
      expect(valid_operation).to eq(valid_move)
      expect(moves).to include(valid_operation)

      valid_positive_negative = [4, 2]
      expect(bishop.move(valid_positive_negative)).to eq(valid_positive_negative)
    end
    it "should return error if it is not a valid move" do
      expect { bishop.move([1, 4]) }.to raise_error(BadMove)
    end
  end
  context "Rook" do
    let(:starting_pos) { [3, 3] }
    let(:rook) { Piece.new("rook") }
    it "should move in any horizontal or vertical" do
      pattern = rook.instance_variable_get(:@movement_pattern)
      directionality = true
      moves = all_valid_moves(starting_pos, pattern, directionality)

      valid_horizontal_move = [8, 3]
      valid_operation = rook.move(valid_horizontal_move)
      expect(valid_operation).to eq(valid_horizontal_move)
      expect(moves).to include(valid_operation)

      valid_vertical_move = [3, 8]
      expect(rook.move(valid_vertical_move)).to eq(valid_vertical_move)
    end
    it "should return error if it is not a valid move" do
      expect { rook.move([1, 4]) }.to raise_error(BadMove)
    end
    xcontext "Queen"
    xcontext "King"
  end
end
