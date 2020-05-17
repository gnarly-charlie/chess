require_relative "Piece"
require_relative "Stepable"

class King < Piece
    include Stepable

    def symbol
        "K"
    end

    def move_diffs
        [[0,1], [1,1], [1,0], [1,-1], [0,-1], [-1,-1], [-1,0], [-1,1]]
    end


end