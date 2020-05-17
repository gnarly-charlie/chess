require "byebug"

module Slideable
    def moves
        move_dirs.each_with_object([]) do |offset, new_coords|
            grow_unblocked_moves(offset).each {|coord| new_coords << coord}
        end
    end

    def grow_unblocked_moves(offset)
        new_coords = []
        curr_row, curr_col = pos
        row_offset, col_offset = offset
        new_pos = [curr_row + row_offset, curr_col + col_offset]
        until board.valid_pos?(new_pos) == false
            new_pos_contents = board[new_pos]
            if new_pos_contents.is_a?(NullPiece)
                new_coords << [new_pos[0], new_pos[1]]
                new_pos[0] += row_offset
                new_pos[1] += col_offset
                next
            end
            if new_pos_contents.colour != self.colour
                new_coords << [new_pos[0], new_pos[1]]
                break
            else
                break
            end
        end
        new_coords
    end

    def move_dirs
        #implemented by subclass
    end

end