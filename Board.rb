require "byebug"
require_relative "Pieces"

class NoPieceError < StandardError
    def message
        "No piece at chosen location"
    end
end

class InvalidMoveError < StandardError
    def message
        "Invalid move for chosen piece"
    end
end

class InvalidPosError < StandardError
    def message
        "Invalid coordinate"
    end
end

class Board
    attr_reader :board

    def initialize
        @board = build_board
    end

    def [](pos)
        row, col = pos
        @board[row][col]
    end

    def []=(pos, val)
        row, col = pos
        @board[row][col] = val
    end

    def valid_pos?(pos)
        return false unless pos.all? {|coord| (0..7).include?(coord)}
        true
    end

    def build_board
        board = [
            build_piece_row(:white, 0),
            build_pawn_row(:white, 1),
            build_nil_row(2),
            build_nil_row(3),
            build_nil_row(4),
            build_nil_row(5),
            build_pawn_row(:black, 6),
            build_piece_row(:black, 7)
        ]
    end

    def build_piece_row(colour, row)
        board_row = []
        board_row << Rook.new(colour, self, [row, 0])
        board_row << Knight.new(colour, self, [row, 1])
        board_row << Bishop.new(colour, self, [row, 2])
        if colour == :white
            board_row << Queen.new(colour, self, [row, 3])
            board_row << King.new(colour, self, [row, 4])
        else
            board_row << King.new(colour, self, [row, 3])
            board_row << Queen.new(colour, self, [row, 4])
        end
        board_row << Bishop.new(colour, self, [row, 5])
        board_row << Knight.new(colour, self, [row, 6])
        board_row << Rook.new(colour, self, [row, 7])
        board_row
    end

    def build_pawn_row(colour, row)
        board_row = []
        (0..7).each {|time| board_row << Pawn.new(colour, self, [row, time])}
        board_row
    end

    def build_nil_row(row)
        board_row = []
        (0..7).each {|time| board_row << NullPiece.new(:null, self, [row, time])}
        board_row
    end

    def input_pos(message)
        begin
            puts message
            input = gets.chomp
            pos = input.split(",").map(&:to_i)
            raise InvalidPosError unless pos.all? {|coord| (0..7).include?(coord)}
        rescue InvalidPosError => e
            puts e.message
            retry
        end
        pos
    end

    def move_piece(start_pos, end_pos)
        #get piece logic
        begin
            #coords = input_pos("Select a piece with input like `1,2`")
            piece = get_piece(start_pos)
        rescue NoPieceError => e
            puts e.message
        end
        
        #place piece logic
        begin
            place_piece(end_pos, piece)
        rescue
            
        end
    end

    def get_piece(pos)
        piece = self[pos]
        if piece.is_a?(Piece)
            self[pos] = NullPiece.new(:null, self, pos)
            return piece
        else
            raise NoPieceError
        end
    end

    def place_piece(pos, place_piece)
        pos_value = self[pos]
        self[pos] = place_piece
        place_piece.pos = pos
    end

    def in_check?(colour)
        
    end

end

# b = Board.new
# b[[2,0]] = Pawn.new(:black, self, [2,0])
# p b


# p b[[1,0]].moves
# p b[[6,0]].moves
