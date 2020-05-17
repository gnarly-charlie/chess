require_relative "Piece"
require_relative "Stepable"

class Knight < Piece
    include Stepable

    def symbol
        "H"
    end

    def move_diffs
        [[2,1], [-2,-1], [1,2], [-1,-2], [2,-1], [-2,1], [1,-2], [-1,2]]
    end


end