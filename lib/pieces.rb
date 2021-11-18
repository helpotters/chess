# lib/pieces.rb
# frozen_string_literal: true

require "matrix"

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

  def array_add(origin, addition)
    # a solution to not using matrix addition; sum two arrays together per x and y
    [origin, addition].transpose.map { |x| x.reduce(:+) }
  end

  # Creates any chess piece based off argument
  class Piece
    def initialize(piece, side, order)
      @piece = @pieces.key(piece)
      @movement_pattern = @pieces.key(piece)
      @pieces = {
        pawn: [[0, 1]],
        knight: [[2, 1], [1, 2]],
        bishop: [[1, 1]],
        rook: [[0, 1], [1, 0]]
      }
      @valid_moves = ValidMoves.new(@piece, @movement_pattern)
      @position = start_position(side, order)
    end

    def move(position)
      raise if @valid_moves.update(position).include?(position)

      position
    end

    def start_position(side, _order)
      case side
      when "white"
        modifier = [0, 0]
      when black
        modifier = [0, 8]
      end

      @movement_pattern.first * modifier
    end
  end

  # Checker Object for Valid Moves
  class ValidMoves
    def initialize(piece, pattern)
      @piece = piece
      @pattern = pattern
      @directional = false
    end

    # def update(move); end

    # # TODO: refactor functions to allow ease of multiple values
    # # helper function for every direction
    # def symmetry_multiply(directions, rotations = [[1, 1], [-1, 1], [-1, -1], [1, -1]])
    #   products = directions.map do |direction|
    #     rotations.each.map { |rotation| [rotation[0] * direction[0], rotation[1] * direction[1]] }
    #   end
    #   products.flatten(1) # each rotation contains a sub-array, must be flat for addition later
    # end

    # # adds
    # def symmetry_add(position, rotations = [[1, 1], [-1, 1], [-1, -1], [1, -1]])
    #   array = rotations.each.map do |rotation|
    #     moves = [(position[0] + rotation[0]), (position[1] + rotation[1])]
    #     next if moves[0] > 8 || moves[0] < 1 # range of chessboard
    #     next if moves[1] > 8 || moves[1] < 1

    #     moves
    #   end
    #   array.compact
    # end

    # # creates an array each valid pos on board
    # # for pieces such rook, queen, and bishop
    # def all_across_board(base_direction)
    #   z = []
    #   (1..8).each do |i| # across board in x and y
    #     x = base_direction[0] * i
    #     y = base_direction[1] * i
    #     next if x > 8  || x.negative? # range of chessboard
    #     next if y > 8  || y.negative?

    #     z.push([x, y])
    #   end
    #   z.compact # nil values caused by off-board postitions
    # end

    # def all_valid_moves(start, patterns, dir = false)
    #   # directional if it is a rook, queen, or bishop
    #   if dir == true && patterns.length > 2
    #     directions = patterns.each.map { |pattern| all_across_board(pattern) }
    #     directions = directions.flatten(1)
    #   elsif dir == true
    #     directions = symmetry_multiply(all_across_board(patterns))
    #   elsif dir == false
    #     directions = symmetry_multiply(patterns)
    #   end

    #   # add valid possible moves to center on existing position of piece
    #   symmetry_add(start, directions)
    # end
  end
end
