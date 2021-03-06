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

class NoValidMovesError < StandardError
    def message
        "Selected piece has no valid moves"
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
        #check if valid move and raise if not
        p_valid_moves = self[start_pos].valid_moves
        raise InvalidMoveError unless p_valid_moves.include?(end_pos)
        #get piece logic
        begin
            piece = get_piece(start_pos)
        rescue NoPieceError => e
            puts e.message
        end
        #place piece logic
        begin
            place_piece(end_pos, piece)
        rescue InvalidMoveError => e
            puts e.message
        end
    end

    def move_piece!(start_pos, end_pos)
        begin
            #coords = input_pos("Select a piece with input like `1,2`")
            piece = get_piece(start_pos)
        rescue NoPieceError => e
            puts e.message
        end
        begin
            place_piece!(end_pos, piece)
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

    def place_piece!(pos, place_piece)
        pos_value = self[pos]
        self[pos] = place_piece
        place_piece.pos = pos
    end

    def in_check?(colour)
        king_pos = find_king(colour)
        board.each do |row|
            row.each do |piece|
                if piece.colour != colour && is_nullpiece?(piece) != true
                    return true if piece.moves.include?(king_pos)
                end
            end
        end
        false
    end

    def checkmate?(colour)
        if in_check?(colour)
            board.each do |row|
                row.each do |piece|
                    next if is_nullpiece?(piece)
                    return false if piece.colour == colour && piece.valid_moves.length > 0
                end
            end
            return true
        end
        king_moves = board[find_king(colour)].valid_moves
        return true if num_pieces(colour) == 1 && king_moves.length == 0
        false
    end

    def num_pieces(colour)
        total = 0
        board.each do |row|
            row.each do |piece|
                total += 1 if piece.colour == colour
            end
        end
        total
    end

    def is_nullpiece?(piece)
        return true if piece.is_a?(NullPiece)
        false
    end

    def find_king(colour)
        board.each do |row|
            row.each do |piece|
                return piece.pos if piece.colour == colour && piece.is_a?(King)
            end
        end
        nil
    end

end

# b = Board.new
# # p b.in_check?(:white)
# # b.place_piece([0, 3], Rook.new(:black, b, [0,3]))
# # p b.in_check?(:white)
# # b[[0,0]].move_into_check?([0,0])
# # p b[[1,0]].valid_moves
# b.move_piece!([0,0], [7,4])
# b.move_piece([7,4], [7,5])
# p b
# p b.checkmate?(:black)

