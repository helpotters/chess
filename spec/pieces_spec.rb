# pieces_spec.rb

require_relative "./../lib/pieces"
include Pieces

RSpec.describe Pieces do

  # helper function for every direction
  def symmetry_multiply(bases, cartesian_chords = [[1, 1], [-1, 1], [-1, -1], [1, -1]])
    bases.each { |base| cartesian_chords.map { |mod| [mod[0] * base[0], mod[1] * base[1]] } }
  end

  def symmetry_add(base, cartesian_chords = [[1, 1], [-1, 1], [-1, -1], [1, -1]])
    cartesian_chords.map { |mod| [mod[0] + base[0], mod[1] + base[1]] }
  end

  context "Pawn" do
    let(:pawn) { Pawn.new([0, 1]) } # a2
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
    let(:knight) { Knight.new(starting_pos) }

    it "should move two blocks plus one block adjacent in any direction" do
      all_directions = symmetry_multiply([[2, 1], [1, 2]])
      all_moves = symmetry_add([4, 4], all_directions)
      valid_positive_move = [6, 5]
      expect(all_moves).to include(knight.move(valid_positive_move))
      valid_negative_move = [3, 2]
      expect { knight.move(valid_negative_move) }.to raise_error(BadMove)
    end
  end
  xcontext "Bishop"
  xcontext "Rook"
  xcontext "Queen"
  xcontext "King"
end
