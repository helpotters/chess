# lib/pieces.rb
# frozen_string_literal: true

require "matrix"
require "byebug"
require "reflections"

# Contains the Object and Rules for the Operations of Chess Pieces
module Pieces
  # An error class used for move validation, which returns the bad move
  class BadMove < ArgumentError
    attr_reader :move

    def initialize(move)
      super
      @move = move
    end

    def message
      "Bad Move: #{move}"
    end
  end

  # Creates any chess piece based off argument
  class Piece
    attr_reader :piece, :position

    PIECE_START_MODIFIER = {
      "pawn" => { start: [0, 1], mod: 1 },
      "rook" => { start: [0, 0], mod: 7 },
      "knight" => { start: [0, 1], mod: 5 },
      "bishop" => { start: [0, 2], mod: 3 },
    }.freeze
    PIECES = {
      "pawn" => { id: "pawn", pattern: [[0, 1]], directional: false, sweeping: false },
      "knight" => { id: "knight", pattern: [[2, 1], [1, 2]], directional: true, sweeping: false },
      "bishop" => { id: "pawn", pattern: [[1, 1]], directional: true, sweeping: true },
      "rook" => { id: "rook", pattern: [[0, 1], [1, 0]], directional: true, sweeping: true },
      "queen" => { id: "pawn", pattern: [[0, 1]], directional: false, sweeping: false },
    }.freeze

    @@existing_pieces = []

    def initialize(piece, side = "white")
      @piece = PIECES[piece].to_h
      @attributes = { turns: 0, id: @piece[:id], side: side }
      @@existing_pieces << self

      @count = 0
      @position = start_position
      @@existing_pieces.each { |piece| @count += 1 if piece.piece[:id] == @piece[:id] }
    end

    def move(new_position)
      check_piece_conditionals
      valid_moves = ValidMoves.new(self)
      raise BadMove, new_position if valid_moves.confirm.none?(new_position)

      new_position
    end

    # Checks for any limitations or conditional modifiers a piece's movement pattern
    def check_piece_conditionals
      return unless @attributes[:id] == "pawn"
      return unless @attributes[:turns] < 2

      piece[:pattern] = [[0, 1], [0, 2]] if @attributes[:turns] == 0
      piece[:pattern] = [[0, 1]] if @attributes[:turns] == 1

      piece[:pattern] = [[0, 1], [-1, 1], [1, 1]] if @position[1] == 3
    end

    def start_position
      # The starting positions reflect across the board
      start_pos = PIECE_START_MODIFIER[@piece[:id]]
      row = start_pos[:start][1] + (@count * start_pos[:mod])
      if @side == "black"
        # flipping column and row diagonally across the board
        [row, start_pos[:start][0] + 8]
      else
        [start_pos[:start][0], row]
      end
    end
  end

  # Checker Object for Valid Moves
  class ValidMoves
    include ChessAssistMethods

    def initialize(piece)
      @piece = piece.piece
      @piece_id = @piece.fetch(:id)
      @position = piece.position
      @pattern = @piece.fetch(:pattern)
      @directional = @piece.fetch(:directional)
      @sweeping = @piece.fetch(:sweeping)
    end

    def confirm(move = @pattern)
      moveset = @directional ? rotational_modify(move) : linear_modify(move)
      moveset.compact
    end

    private

    def rotational_modify(move)
      board_moves = @sweeping ? all_across_board(move) : move
      pattern_reflections = reflect_pattern(board_moves)
      modify_from_position(@position, pattern_reflections)
    end

    def linear_modify(moves)
      modify_from_position(@position, moves)
    end
  end
end
