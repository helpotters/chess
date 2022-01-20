# frozen_string_literal: true

require_relative "chess/version"

module Chess
  class Error < StandardError; end

  # Your code goes here...
end

class Board
  attr_reader :board_info

  def initialize
    @board_info = Array.new(8, [])
  end
end
