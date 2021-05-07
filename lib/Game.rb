class Game
  @move_definetily_repeated = false
  def initialize(_player1, _player2)
    @n = 0
    @moves_used = []
  end

  def start
    system 'clear'

    puts "
      \t ██╗░░░░░░█████╗░░█████╗░██████╗░██╗███╗░░██╗░██████╗░░░░░░░░░░
      \t ██║░░░░░██╔══██╗██╔══██╗██╔══██╗██║████╗░██║██╔════╝░░░░░░░░░░
      \t ██║░░░░░██║░░██║███████║██║░░██║██║██╔██╗██║██║░░██╗░░░░░░░░░░
      \t ██║░░░░░██║░░██║██╔══██║██║░░██║██║██║╚████║██║░░╚██╗░░░░░░░░░
      \t ███████╗╚█████╔╝██║░░██║██████╔╝██║██║░╚███║╚██████╔╝██╗██╗██╗
      \t ╚══════╝░╚════╝░╚═╝░░╚═╝╚═════╝░╚═╝╚═╝░░╚══╝░╚═════╝░╚═╝╚═╝╚═╝"

    # Create Variable to Tic tac toe's board
    @game_board = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
  end

  # Display the Tic tac toe's board
  def display_board
    (0..2).each do |i|
      puts "\t +---+---+---+"
      print "\t"
      (0..7).each do |j|
        print ' | ' unless j.odd?
        print @game_board[i][((j * 3) / 7).to_i] unless j.even?
      end
      puts i == 2 ? "\n\t +---+---+---+" : "\t nil"
    end
  end

  def moves_used(move_used)
    @moves_used[@n] = move_used
    @n += 1
    @moves_used.compact
  end

  def read_moves_used
    @moves_used
  end

  def check_moves_repeated(move_likely_repeated)
    move_definetily_repeated = false
    return unless @moves_used

    @moves_used.each do |value|
      move_definetily_repeated = true unless value.to_i != move_likely_repeated
    end
  end

  def update_board(pos_selected, new_element)
    @game_board.each do |board_row|
      (0..2).each do |board_element|
        board_row[board_element] = new_element if board_row[board_element] == pos_selected
      end
    end
  end
end
