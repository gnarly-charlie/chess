require_relative "Piece"
require_relative "Slideable"

class Queen < Piece
    include Slideable

    def symbol
        "Q"
    end

    def move_dirs
        [[1,1], [-1,-1], [1,-1], [-1,1], [1,0], [0,1], [-1,0], [0,-1]]
    end
    
end