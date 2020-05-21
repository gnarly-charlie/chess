require_relative "Cursor"

class Player
    attr_reader :colour
    attr_accessor :display

    def initialize(colour, display)
        @colour = colour
        @display = display
    end

    def inspect
        self.colour.inspect
    end

    def make_move
        move = nil
        until move != nil
            display.render
            move = display.cursor.get_input
        end
        move
    end

end