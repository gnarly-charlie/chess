

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
        moves.each_with_object([]) do |move, valid_coords|
            valid_coords << move if move_into_check?(move) != true
        end
    end

    def move_into_check?(end_pos)
        board_copy = Marshal.load(Marshal.dump(board))
        copy_piece = board_copy[self.pos]
        board_copy.move_piece!(copy_piece.pos, end_pos)
        return true if board_copy.in_check?(copy_piece.colour)
        false
    end 

    def is_nullpiece?(piece)
        return true if piece.is_a?(NullPiece)
        false
    end

end