# frozen_string_literal: true

<<<<<<< HEAD
RSpec.describe Chess do
  xdescribe "Board Representation" do
    xcontext "should create a board from an 8x8 nested array" do
      xit "should be accessible via row/column values"
      xit "should be empty"
    end
    xcontext "should contain information about the environment" do
      xcontext "metadata" do
        xit "should contain information about what piece is occupying a space"
        xit "should expect find side assignment for any occupying piece"
        xit "should receive positional updates from pieces"
        xit "should receive information about the paths a piece can move in"
        xit "should receive info about pieces attacking or defending a position"
=======
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
>>>>>>> 108f345 (test: Initialize 8x8 Board Array)
      end
    end
  end
end
