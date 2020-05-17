

class Piece
    attr_reader :board, :colour
    attr_accessor :pos

    def initialize (colour, board, pos)
        @type = :piece
        @colour = colour
        @board = board
        @pos = pos
    end

    def inspect
        @type.inspect
        #{ 'type' => @type, 'colour' => @colour }.inspect
    end

    def valid_moves

    end

end