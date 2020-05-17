require_relative "Piece"
require_relative "Slideable"

class Bishop < Piece
    include Slideable

    def symbol
        "B"
    end

    def move_dirs
        [[1,1], [-1,-1], [1,-1], [-1,1]]
    end
    
end