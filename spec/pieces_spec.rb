# pieces_spec.rb

require_relative "./../lib/pieces"
include Pieces

RSpec.describe Pieces do
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
  xcontext "Knight"
  xcontext "Bishop"
  xcontext "Rook"
  xcontext "Queen"
  xcontext "King"
end
