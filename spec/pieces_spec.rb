# pieces_spec.rb

require_relative "./../lib/pieces"
include Pieces

RSpec.describe Pieces do
  context "Pawn" do
    let(:pawn) { Pawn.new([0, 1]) } # a2
    it "have choice to travel two columnar places in first move" do
      valid_move = [0, 3] # a4
      pawn.move(valid_move)
      expect(pawn.position).to eq(valid_move)
      invalid_move = [0, 5] # a6
      expect { pawn.move(invalid_move) }.to raise_error(BadMove)
    end
    xit "have choice for en passasnt in first move"
    xit "should have choice to capture diagonally"
    xit "should only travel one square"
  end
  xcontext "Knight"
  xcontext "Bishop"
  xcontext "Rook"
  xcontext "Queen"
  xcontext "King"
end
