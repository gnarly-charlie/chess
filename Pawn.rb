require_relative "Piece"

class Pawn < Piece

    def symbol
        "P"
    end

    def moves
        new_coords = []
        side_attacks.each {|attack_pos| new_coords << attack_pos}
        new_pos = [pos[0] + forward_dir, pos[1]]
        new_pos_contents = board[new_pos]
        if new_pos_contents.is_a?(NullPiece)
            forward_empty = true
            new_coords << [new_pos[0], new_pos[1]]
        end

        if at_start_row? && forward_empty
            new_pos = [pos[0] + (2 * forward_dir), pos[1]]
            new_pos_contents = board[new_pos]
            new_coords << [new_pos[0], new_pos[1]] if new_pos_contents.is_a?(NullPiece)
        end
        new_coords
    end

    def forward_dir
        return 1 if self.colour == :white
        -1
    end

    def at_start_row?
        if self.colour == :white
            return true if self.pos[0] == 1
        end

        if self.colour == :black
            return true if self.pos[0] == 6
        end
        false
    end

    def side_attacks
        attack_pos = []
        left_attack_pos = [pos[0] + self.forward_dir, pos[1] - 1]
        right_attack_pos = [pos[0] + self.forward_dir, pos[1] + 1]
        left_attack_contents = board[left_attack_pos]
        right_attack_contents = board[right_attack_pos]
        if left_attack_contents.is_a?(NullPiece) != true
            attack_pos << left_attack_pos if left_attack_contents.colour != self.colour
        end
        if right_attack_contents.is_a?(NullPiece) != true
            attack_pos << right_attack_pos if right_attack_contents.colour != self.colour
        end
        attack_pos
    end

end