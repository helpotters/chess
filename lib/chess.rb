# frozen_string_literal: true

require_relative "chess/version"

module ChessBoard
  class Error < StandardError; end

  # Creates and Operates a Chess Game
  class Chess
    def initialize
    end

    def input(move)
      raise ArgumentError unless move.is_a?(String)

      piece = move.split.select { /[[:alpha]]/ }.join.to_s
      piece_input(piece)
    end

    private

    def piece_input(piece)
      piece_matrix = %w[K B N R P]
      begin
        piece_symbol = piece.upcase.strip
        # Knight converts to King if using #split.first
        # Only allow algrebraic notation
        raise if piece_symbol.length > 1 || piece_symbol.length < 1

        piece_symbol = piece_symbol.split.first.to_s
        raise ArgumentError.new("Not chess notation") if piece_matrix.none?(piece_symbol)

        { piece: piece_symbol }
      end
    end
  end
end
