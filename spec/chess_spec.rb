# frozen_string_literal: true

require "chess"

RSpec.describe Chess do
end
RSpec.describe Board do
  context "Board Representation" do
    subject(:chessboard) { Board.new }
    subject(:board_info) { chessboard.board_info }
    it "should initialize an 8x8 nested array" do
      expect(board_info).to be_an_instance_of(Array)
      expect(board_info.length).to eq(8)
      board_info.each do |row|
        expect(row).to be_an_instance_of(Array)
      end
    end
  end
end
RSpec.describe Piece do
end
RSpec.describe Moves do
end
RSpec.describe Game do
end
RSpec.describe Player do
end
