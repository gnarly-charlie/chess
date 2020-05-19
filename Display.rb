require "colorize"
require_relative "Board"
require_relative "Cursor"

class Display
    attr_accessor :board, :cursor

    def initialize
        @board = Board.new
        @cursor = Cursor.new([0,0], board)
        render
    end

    def render
        system("clear")
        puts "   0  1  2  3  4  5  6  7"
        (0..7).each {|time| puts row_render(time)}
    end

    def test
        until false
            render
            cursor.get_input
        end
    end

    private

    def row_render(row)
        row_string = "#{row}  "
        board.board[row].each.with_index do |piece, col|
            row_string += "#{piece.symbol}".colorize(:color => piece.colour, :background => background_colour(row, col))
            row_string += "  ".colorize(:background => :blue) unless col == 7
        end
        row_string
    end

    def background_colour(row, col)
        if [row, col] == cursor.cursor_pos && cursor.selected
            :green
        elsif [row, col] == cursor.cursor_pos
            :red
        else
            :blue
        end
    end

end

d = Display.new
d.test