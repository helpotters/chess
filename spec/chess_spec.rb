# frozen_string_literal: true

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
      end
    end
  end
end
