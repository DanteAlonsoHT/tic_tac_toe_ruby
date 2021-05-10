class Game
  def initialize(_player1, _player2)
    @n = 0
    @moves_used = []
  end

  def start
    system 'clear'

    @game_board = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
  end

  def return_game_board
    @game_board
  end

  def moves_used(move_used)
    @moves_used[@n] = move_used
    @n += 1
    @moves_used = @moves_used.compact
  end

  def read_moves_used
    @moves_used
  end

  def check_moves_repeated(move_likely_repeated)
    return false if @moves_used.empty?

    @moves_used.each do |value|
      return true if value.to_i == move_likely_repeated
    end
    false
  end

  def update_board(pos_selected, new_element)
    @game_board.each do |board_row|
      (0..2).each do |board_element|
        board_row[board_element] = new_element if board_row[board_element] == pos_selected
      end
    end
  end
end
