


class Piece

    def initialize (type, colour)
        @type = type
        @colour = colour
    end

    def inspect
        @type.inspect
        #{ 'type' => @type, 'colour' => @colour }.inspect
    end

end