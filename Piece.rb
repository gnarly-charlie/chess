

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
        self.symbol.inspect
        #{ 'type' => @type, 'colour' => @colour }.inspect
    end

    def symbol
    end

    def valid_moves

    end

    def is_nullpiece?(piece)
        return true if piece.is_a?(NullPiece)
        false
    end

end