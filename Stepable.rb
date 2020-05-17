module Stepable
    def moves
        move_diffs.each_with_object([]) do |offset, new_coords|
            curr_row, curr_col = pos
            row_offset, col_offset = offset
            new_pos = [curr_row + row_offset, curr_col + col_offset]
            next unless board.valid_pos?(new_pos)
            new_pos_contents = board[new_pos]
            new_coords << new_pos if new_pos_contents.colour != self.colour
        end
    end

    def move_offsets
        #implemented by subclass
    end

end