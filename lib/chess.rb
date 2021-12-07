# frozen_string_literal: true

require_relative "chess/version"
require_relative "pieces"

module ChessGame
  class Error < StandardError; end

  # Error Specification for Non-Algebraic Notation
  class NotationError < StandardError
    def message
      "Incorrect notation"
    end
  end

  # Initializes and Operates a Chess Game
  class Game
    def initialize
      @board = Board.new
      @white = Player.new
      @black = Player.new
      players = [@white, @black]
    end

    def play
      players.each do |player|
        place_piece(player)
      rescue NotationError
        retry
      end
    end

    private

    def place_piece(player)
      request = @board.request(player)
      player.input(request)
    end
  end

  # Manages the Positional Data
  class Board
    attr_accessor :board_matrix

    def initialize
      @board_matrix = [
        [nil, nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil, nil]
      ]
    end

    @players =

      def occupy(space, piece)
        row = space[0]
        column = space[1]
        # It is accessing an array within an array, hence
        # [top-level array][nested array]
        raise unless @board_matrix[row][column].nil?

        @board_matrix[row][column] = piece
      end
  end

  # Controls Pieces and Inputs
  class Player
    include Pieces

    def initialize(side = "white")
      @pawns = []
      8.times { @pawns.push(Piece.new("pawn", side)) }
      @bishops = Piece.new("bishop", side), Piece.new("bishop", side)
      @knights = Piece.new("knight", side), Piece.new("knight", side)
      @rooks = Piece.new("rook", side), Piece.new("rook", side)
      @queen = Piece.new("queen", side)
      @king = Piece.new("king", side)
      @pieces = [@pawns, @bishops, @knights, @rooks, @queen, @king].flatten
    end

    def input(move)
      raise NotationError unless move.is_a?(String)
      raise NotationError unless move.length == 3

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
      { piece: piece_output, location: location_output } # str, arr>str
    end

    private

    def piece_input(piece)
      piece_matrix = %w[K Q B N R P]
      begin
        # Knight converts to King if using #split.first
        # Only allow algrebraic notation
        raise NotationError, "No pieces" if piece.empty?
        raise NotationError, "Not chess notation" unless piece_matrix.include?(piece)

        piece
      end
    end

    def location_input(column, row)
      letter_range = %w[a b c d e f g h] # column
      number_range = (0..8).to_a # row
      raise NotationError unless letter_range.include?(column)

      raise NotationError unless number_range.include?(row)

      [column, row]
    end
  end
end
