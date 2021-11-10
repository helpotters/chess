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

    def initialize(starting_pos)
      @position = starting_pos
      @times_moved = 0
      @movement_matrix = nil
      @two_ranks = [0, 2]
    end

    def move(place)
      movement_matrix
      movement_positions = @movement_matrix.map { |movement| array_add(movement, position) }
      raise BadMove, place if movement_positions.none?(place)

      @times_moved += 1 # Two-rank movement disabled after first move

      @position = place
    end

    private

    def movement_matrix
      @movement_matrix = []
      @movement_matrix << @two_ranks if @times_moved.zero? # disabled after first move
    end
  end

  class Bishop
  end

  class Knight
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
end
