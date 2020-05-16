require "byebug"
require_relative "Piece"

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

    def build_board
        board = [
            build_piece_row(:white, 0),
            build_piece_row(:white, 1),
            build_nil_row,
            build_nil_row,
            build_nil_row,
            build_nil_row,
            build_piece_row(:black, 6),
            build_piece_row(:black, 7)
        ] 
    end

    def build_piece_row(colour,row)
        board_row = []
        (0..7).each {|time| board_row << Piece.new(colour, self, [row, time])}
        board_row
    end

    def build_nil_row
        row = []
        (1..8).each {|time| row << "nil"}
        row
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
            self[pos] = "nil"
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

end

b = Board.new
b.move_piece([0,0],[0,3])
p b[[0,3]].pos

