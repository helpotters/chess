# lib/reflections.rb

# Methods that help with directional operations
module ChessAssistMethods
  # Creates a general pattern of moves be
  def reflect_pattern(directions, rotations = [[1, 1], [-1, 1], [-1, -1], [1, -1]])
    # multiply
    products = directions.map do |direction|
      rotations.each.map { |rotation| [rotation[0] * direction[0], rotation[1] * direction[1]] }
    end
    products.compact
    reflect_from_position(products)
  end

  # Returns an array of valid moves from current row, column
  def modify_from_position(directions, rotations = [[1, 1], [-1, 1], [-1, -1], [1, -1]])
    rotations.each.map do |rotation|
      moves = [(rotation[0] + directions[0]).to_i, (rotation[1] + directions[1]).to_i]
      next if moves[0] > 7 || moves[0] < 0 # range of chessboard
      next if moves[1] > 7 || moves[1] < 0

      moves.compact
    end
  end

  # creates an array each valid pos on board
  # for pieces such rook, queen, and bishop
  def all_across_board(base_direction)
    z = []
    (1..8).each do |i| # across board in x and y
      x = base_direction[0] * i
      y = base_direction[1] * i
      next if x > 8 || x.negative? # range of chessboard
      next if y > 8 || y.negative?

      z.push([x, y])
    end
    z.compact # nil values caused by off-board postitions
  end

  def array_add(origin, addition)
    # a solution to not using matrix addition; sum two arrays together per x and y
    [origin, addition].transpose.map { |x| x.reduce(:+) }
  end
end
