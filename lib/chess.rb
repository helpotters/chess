# frozen_string_literal: true

require_relative "chess/version"

module ChessBoard
  class Error < StandardError; end

  class NotationError < StandardError
  end

  # Creates and Operates a Chess Game
  class Chess
    def initialize; end

    def input(move)
      raise ArgumentError unless move.is_a?(String)
      raise ArgumentError unless move.length ==  3
      # Notation is limited to proper algebraic 3 char inputs
      piece = move.scan(/\p{Upper}/).first.to_s
      column = move.scan(/\p{Lower}/).first.to_s
      row = move.scan(/\p{Digit}/).first.to_i

      begin
        piece_output = piece_input(piece)
        location_output = location_input(column, row)
      rescue ArgumentError
        piece_output = piece_input(piece)
        location_output = [nil, nil]
      end
      { piece: piece_output, location: location_output }
    end

    private

    def piece_input(piece)
      piece_matrix = %w[K Q B N R P]
      begin
        # Knight converts to King if using #split.first
        # Only allow algrebraic notation
        raise ArgumentError.new("No pieces") if piece.empty?
        raise ArgumentError.new("Not chess notation") unless piece_matrix.include?(piece)

        piece
      end
    end

    def location_input(column, row)
      letter_range = %w[a b c d e f g h] # column
      number_range = (0..8).to_a # row
      raise ArgumentError unless letter_range.include?(column)

      raise ArgumentError unless number_range.include?(row)

      [column, row]
    end
  end
end
