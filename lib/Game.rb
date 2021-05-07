class Game
    @@moves_used = []
    @move_definetily_repeated = false
    def initialize(_player1, _player2)
      @n = 0
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
          print ' | ' if j.even?
          print @game_board[i][((j * 3) / 7).to_i] if j.odd?
        end
        puts i == 2 ? "\n\t +---+---+---+" : "\t #{nil}"
      end
    end