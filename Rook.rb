require_relative "Piece"
require_relative "Slideable"

class Rook < Piece
    include Slideable

    def symbol
        "R"
    end

    def move_dirs
        [[1,0], [0,1], [-1,0], [0,-1]]
    end


end