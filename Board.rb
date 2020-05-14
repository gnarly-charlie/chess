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

    def build_board
        board = [
            build_special_row("white"),
            build_pawn_row("white"),
            build_nil_row,
            build_nil_row,
            build_nil_row,
            build_nil_row,
            build_pawn_row("black"),
            build_special_row("black")
        ] 
    end

    def build_pawn_row(colour)
        row = []
        (1..8).each {|time| row << Piece.new("Pawn",colour)}
        row
    end

    def build_special_row(colour)
        row = []
        (1..8).each {|time| row << Piece.new("Special",colour)}
        row
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

    def move_piece
        #get piece logic
        begin
            coords = input_pos("Select a piece with input like `1,2`")
            piece = get_piece(coords)
        rescue NoPieceError => e
            puts e.message
            retry
        end
        #place piece logic
        begin
            coords = input_pos("Where's it going?")
            place_piece(coords, piece)
        rescue
            retry
        end
    end

    def get_piece(pos)
        row, col = pos
        piece = @board[row][col]
        if piece.is_a?(Piece)
            @board[row][col] = "nil"
            return piece
        else
            raise NoPieceError
        end
    end

    def place_piece(pos, place_piece)
        row, col = pos
        pos_value = @board[row][col]
        # if pos_value.is_a?(Piece)
        #     return piece
        # else
        #     raise NoPieceError
        # end
        @board[row][col] = place_piece
    end

end

b = Board.new
b.move_piece

