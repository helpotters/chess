# frozen_string_literal: true

require_relative "chess/version"

module ChessBoard
  class Error < StandardError; end

  # Creates and Operates a Chess Game
  class Chess
    def initialize
    end

    def input(move)
      move_matrix = %w[K B N R P]
      begin
        raise Exception if !move.is_a?(String)

        move_symbol = move.upcase.strip
        # Knight converts to King if using #split.first
        # Only allow algrebraic notation
        raise if move_symbol.length > 1 || move_symbol.length < 1
        move_symbol = move_symbol.split.first.to_s
        raise "Not chess notation" if move_matrix.none?(move_symbol)
        { move: move_symbol }
      end
    end
  end
end
