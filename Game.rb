require "byebug"
require_relative "Display"
require_relative "Board"
require_relative "Player"

class Game
    attr_reader :board, :display, :player1, :player2
    attr_accessor :current_player, :other_player

    class InvalidSelectionError < StandardError
        def message
            "Invalid selection"
        end
    end

    def initialize
        @board = Board.new
        @display = Display.new(board)
        @player1 = Player.new(:white, display)
        @player2 = Player.new(:black, display)
        @current_player = player1
        @other_player = player2
    end

    def play
        game_over = false
        until game_over
            take_turn
            swap_turn
            game_over = board.checkmate?(current_player.colour)
        end
        display.notifications = "#{other_player.colour} wins!"
        display.render
    end

    def take_turn
        begin
            start_pos = current_player.make_move
            start_piece = board[start_pos]
            raise InvalidSelectionError unless board[start_pos].colour == current_player.colour
            raise NoValidMovesError unless start_piece.valid_moves.length > 0
        rescue InvalidSelectionError => e
            display.cursor.toggle_selected
            notify_players(e.message)
            retry
        rescue NoValidMovesError => e
            display.cursor.toggle_selected
            notify_players(e.message)
            retry
        end
        
        begin
            end_pos = current_player.make_move
            board.move_piece(start_pos, end_pos)
        rescue InvalidMoveError => e
            display.cursor.toggle_selected
            notify_players(e.message)
            retry
        end
    end

    def notify_players(message)
        display.notifications = message
    end

    def swap_turn
        if current_player == player1
            self.current_player = player2 
            self.other_player = player1
        else
            self.current_player = player1
            self.other_player = player2
        end
        notify_players("#{current_player.colour}'s turn")
    end

end

g = Game.new
g.play