# lib/pieces.rb

require "matrix"

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
      @movement_matrix = [2, 1], [1, 2]
    end

    def move(place)
      valid_moves = symmetry_add(@starting_pos, movement_matrix)

      raise BadMove, place if valid_moves.none?(place)

      place
    end

    def movement_matrix
      @movement_matrix = symmetry_multiply(@movement_matrix.flatten(1))
    end
  end

  class Bishop
  end

  class Rook
  end

  class Queen
  end

  class King
  end

  def array_add(origin, addition)
    [origin, addition].transpose.map { |x| x.reduce(:+) }
  end

  def symmetry_multiply(base, cartesian_chords = [[1, 1], [-1, 1], [-1, -1], [1, -1]])
    cartesian_chords.map { |mod| [mod[0] * base[0], mod[1] * base[1]] }
  end

  def symmetry_add(base, cartesian_chords = [[1, 1], [-1, 1], [-1, -1], [1, -1]])
    cartesian_chords.map { |mod| [mod[0] + base[0], mod[1] + base[1]] }
  end
end
