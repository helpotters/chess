# frozen_string_literal: true
# !/usr/bin/env ruby

require_relative "chess/version"

module ChessBoard
  class Error < StandardError; end

  # Creates and Operates a Chess Game
  class Chess
    def initialize
      @board_matrix = {
        eight: %w[R N B K Q B N R],
        seven: %w[P P P P P P P P],
        six: [nil, nil, nil, nil, nil, nil, nil, nil],
        five: [nil, nil, nil, nil, nil, nil, nil, nil],
        four: [nil, nil, nil, nil, nil, nil, nil, nil],
        three: [nil, nil, nil, nil, nil, nil, nil, nil],
        two: %w[P P P P P P P P],
        one: %w[R N B K Q B N R],
      }
    end

    def input(move)
      raise ArgumentError unless move.is_a?(String)

      piece = move.split.select { /[[:alpha]]/ }.join.to_s
      piece_input(piece)
    end

    def board(location)
      location = input(location)
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
