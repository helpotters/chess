# pieces_spec.rb

require_relative "./../lib/pieces"
include Pieces

RSpec.describe Pieces do
  context "Pawn" do
    let(:pawn) { Piece.new("pawn") } # a2
    before do
      pawn.instance_variable_set(:@position, [0, 1])
    end
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
    xit "should have choice to capture diagonally" do
      pawn.instance_variable_set(:@position, [0, 3])
      capture = [1, 4]
      expect(pawn.move(capture)).to eq(capture)
    end
    # TODO: figure out legality checks
    xit "have choice for en passasnt in first move"
  end
  context "Knight" do
    let(:knight) { Piece.new("knight") }
    let(:valid_moves) { ValidMoves.new(knight) }

    it "should move two blocks plus one block adjacent in any direction" do
      knight.instance_variable_set(:@position, [4, 4])
      moves = valid_moves.confirm([[2, 1], [1, 2]])
      valid_positive_move = [6, 5]
      expect(moves).to include(knight.move(valid_positive_move))
      valid_negative_move = [4, 2]
      expect { knight.move(valid_negative_move) }.to raise_error(BadMove)
    end
  end
  context "Bishop" do
    let(:bishop) { Piece.new("bishop") }
    let(:valid_moves) { ValidMoves.new(bishop) }
    it "should move in any diagonal" do
      bishop.instance_variable_set(:@position, [0, 1])
      moves = valid_moves.confirm

      valid_move = [6, 7]
      valid_operation = bishop.move(valid_move)
      expect(valid_operation).to eq(valid_move)

      valid_move = [1, 0]
      valid_operation = bishop.move(valid_move)
      expect(moves).to include(valid_operation)
    end
    it "should return error if it is not a valid move" do
      expect { bishop.move([1, 4]) }.to raise_error(BadMove)
    end
  end
  context "Rook" do
    let(:starting_pos) { [3, 3] }
    let(:rook) { Piece.new("rook") }
    let(:valid_moves) { ValidMoves.new(rook) }
    it "should move in any horizontal or vertical" do
      rook.instance_variable_set(:@position, starting_pos)
      moves = valid_moves.confirm

      valid_horizontal_move = [7, 3]
      valid_operation = rook.move(valid_horizontal_move)
      expect(valid_operation).to eq(valid_horizontal_move)
      expect(moves).to include(valid_operation)

      valid_vertical_move = [3, 7]
      expect(rook.move(valid_vertical_move)).to eq(valid_vertical_move)
    end
    it "should return error if it is not a valid move" do
      expect { rook.move([1, 4]) }.to raise_error(BadMove)
    end
    xcontext "Queen"
    xcontext "King"
  end
end
