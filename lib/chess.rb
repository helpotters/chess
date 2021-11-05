# frozen_string_literal: true
# !/usr/bin/env ruby

require_relative "chess/version"

module ChessBoard
  class Error < StandardError; end

  class NotationError < StandardError
    def message
     "Incorrect notation"
    end
  end

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
      raise NotationError.new unless move.is_a?(String)
      raise NotationError.new unless move.length ==  3
      # Notation is limited to proper algebraic 3 char inputs
      piece = move.scan(/\p{Upper}/).first.to_s
      column = move.scan(/\p{Lower}/).first.to_s
      row = move.scan(/\p{Digit}/).first.to_i

      begin
        piece_output = piece_input(piece)
        location_output = location_input(column, row)
      rescue NotationError
        piece_output = piece_input(piece)
        location_output = [nil, nil]
      end
      { piece: piece_output, location: location_output }
    end

    def board(location)
      location = input(location)
    end

    private

    def piece_input(piece)
      piece_matrix = %w[K Q B N R P]
      begin
        # Knight converts to King if using #split.first
        # Only allow algrebraic notation
        raise NotationError.new("No pieces") if piece.empty?
        raise NotationError.new("Not chess notation") unless piece_matrix.include?(piece)

        piece
      end
    end

    def location_input(column, row)
      letter_range = %w[a b c d e f g h] # column
      number_range = (0..8).to_a # row
      raise NotationError.new unless letter_range.include?(column)

      raise NotationError.new unless number_range.include?(row)

      [column, row]
    end
  end
end
