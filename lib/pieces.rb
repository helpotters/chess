# lib/pieces.rb

require "matrix"
require "pry-nav"

module Pieces
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

  class Pawn
    attr_reader :position

    # BUG: should not have starting default
    def initialize(starting_pos = [0, 2])
      @position = starting_pos
      @times_moved = 0
      @movement_matrix = nil
      @one_rank = [0, 1]
      @two_ranks = [0, 2]
      @capture = [1, 1], [-1, -1]
    end

    def move(place)
      movement_matrix
      movement_positions = @movement_matrix.map { |movement| array_add(movement, position) }
      raise BadMove, place if movement_positions.none?(place)

      @times_moved += 1 # Two-rank movement disabled after first move

      place
    end

    private

    def movement_matrix
      @movement_matrix = []
      @capture.each { |movement| @movement_matrix << movement }
      @movement_matrix << @one_rank
      @movement_matrix << @two_ranks if @times_moved.zero? # disabled after first move
    end
  end

  # The Knight can move two blocks plus one adjacent
  class Knight
    def initialize(starting_pos)
      @starting_pos = starting_pos
      @movement_pattern = [2, 1], [1, 2]
    end

    def move(place)
      valid_moves = all_valid_moves(@starting_pos, @movement_pattern)

      raise BadMove, place if valid_moves.none?(place)

      place
    end

    def movement_matrix
      @movement_matrix = symmetry_multiply(@movement_matrix.flatten(1))
    end
  end

  # The bishop can move along any of its diagonals
  class Bishop
    def initialize(starting_pos)
      @starting_pos = starting_pos
      @movement_pattern = [1, 1]
    end

    def move(place)
      raise BadMove, place if all_valid_moves(@starting_pos, @movement_pattern, true).none?(place)

      place
    end
  end

  # Piece can travel along any horizontal or vertical
  class Rook
    def initialize(starting_pos)
      @starting_pos = starting_pos
      @movement_pattern = [all_across_board([1, 0]), all_across_board([0, 1])].flatten(2)
    end

    def move(place)
      raise BadMove, place if all_valid_moves(@starting_pos, @movement_pattern, true).none?(place)

      place
    end
  end

  class Queen
  end

  class King
  end

  def array_add(origin, addition)
    # a solution to not using matrix addition; sum two arrays together per x and y
    [origin, addition].transpose.map { |x| x.reduce(:+) }
  end

  # TODO: refactor functions to allow ease of multiple values
  # helper function for every direction
  def symmetry_multiply(directions, rotations = [[1, 1], [-1, 1], [-1, -1], [1, -1]])
    products = directions.map do |direction|
      rotations.each.map { |rotation| [rotation[0] * direction[0], rotation[1] * direction[1]] }
    end
    products.flatten(1) # each rotation contains a sub-array, must be flat for addition later
  end

  # adds
  def symmetry_add(position, rotations = [[1, 1], [-1, 1], [-1, -1], [1, -1]])
    array = rotations.each.map do |rotation|
      moves = [(position[0] + rotation[0]), (position[1] + rotation[1])]
      next if moves[0] > 8 || moves[0] < 1 # range of chessboard
      next if moves[1] > 8 || moves[1] < 1

      moves
    end
    array.compact
  end

  # creates an array each valid pos on board
  # for pieces such rook, queen, and bishop
  def all_across_board(base_direction)
    z = []
    (1..8).each do |i| # across board in x and y
      x = base_direction[0] * i
      y = base_direction[1] * i
      next if x > 8  || x.negative? # range of chessboard
      next if y > 8  || y.negative?

      z.push([x, y])
    end
    z.compact # nil values caused by off-board postitions
  end

  def all_valid_moves(start, patterns, dir = false)
    # directional if it is a rook, queen, or bishop
    if dir == true && patterns.length > 2
      directions = patterns.each.map { |pattern| all_across_board(pattern) }
      directions = directions.flatten(1)
    elsif dir == true
      directions = symmetry_multiply(all_across_board(patterns))
    elsif dir == false
      directions = symmetry_multiply(patterns)
    end

    # add valid possible moves to center on existing position of piece
    symmetry_add(start, directions)
  end
end
