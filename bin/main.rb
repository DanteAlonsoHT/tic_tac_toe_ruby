#!/usr/bin/env ruby

  def moves_used(move_used)
    @@moves_used[@n] = move_used
    @n += 1
    @@moves_used.compact
  end

  def get_moves_used
    @@moves_used
  end

  def check_moves_repeated(move_likely_repeated)
    move_definetily_repeated = false
    if @@moves_used
      @@moves_used.each do |value|
        if value.to_i == move_likely_repeated
          move_definetily_repeated = true  
        end
      end
    move_definetily_repeated
    end
  end

  def update_board(pos_selected, new_element)
    @game_board.each do |board_row|
      (0..2).each do |board_element|
        if board_row[board_element] == pos_selected
          board_row[board_element] = new_element
        end
      end
    end
  end
end
# Class to include attributes/methods of Game and saving names for each player
class Players < Game
  attr_reader :player1, :player2

  @@marker = []
  @@marker2 = []

  def initialize(player1, player2)
    super
    @player1 = player1
    @player2 = player2
    @i = 0
    @j = 0
  end

  def save_marker_player1(move_selected)
    @@marker[@i] = move_selected
    @i += 1
  end

  def save_marker_player2(move_selected2)
    @@marker2[@j] = move_selected2
    @j += 1
  end

  def player1_marker
    @@marker.permutation(3).to_a
  end

  def player2_marker
    @@marker2.permutation(3).to_a
  end
end

system 'clear'

puts "
\t    
\t░██╗░░░░░░░██╗███████╗██╗░░░░░░█████╗░░█████╗░███╗░░░███╗███████╗
\t░██║░░██╗░░██║██╔════╝██║░░░░░██╔══██╗██╔══██╗████╗░████║██╔════╝
\t░╚██╗████╗██╔╝█████╗░░██║░░░░░██║░░╚═╝██║░░██║██╔████╔██║█████╗░░
\t░░████╔═████║░██╔══╝░░██║░░░░░██║░░██╗██║░░██║██║╚██╔╝██║██╔══╝░░
\t░░╚██╔╝░╚██╔╝░███████╗███████╗╚█████╔╝╚█████╔╝██║░╚═╝░██║███████╗
\t░░░╚═╝░░░╚═╝░░╚══════╝╚══════╝░╚════╝░░╚════╝░╚═╝░░░░░╚═╝╚══════╝ \n \n"

puts "\t to an amazing game :D -> Ruby's Tic Tac Toe"
puts "\t Please, give me two names to each player \n \n"

puts "First player name: "
player1 = gets.chomp.capitalize

while player1.empty?
  puts "\t Invalid name, try again!
  \n First player name: "
  player1 = gets.chomp.capitalize
end

puts "Second player name: "
player2 = gets.chomp.capitalize

while player2.empty?
  puts "\t Invalid name, try again!
  \n Second player name: "
  player2 = gets.chomp.capitalize
end

game_trial = Players.new(player1, player2)

puts "\n \t #{game_trial.player1} is going to play 'X', and #{game_trial.player2} will play 'O'"
puts "\t Let's start"

sleep(3)

game_trial.start

sleep(2)

# Combinations to win
combinations_likely_to_win = [[1, 2, 3], [2, 5, 8], [3, 6, 9], [4, 5, 6], [1, 4, 7], [1, 5, 9], [3, 5, 7], [7, 8, 9]]

#Create permutations
combinations_likely_to_win.each do |values_to_win|
  combinations_likely_to_win += [values_to_win.rotate(2)]
  combinations_likely_to_win += [values_to_win.rotate(-2)]
end

# Variable can control the iterations
iterator = 0
winner = 0
game_state = true
move_repeated = false

# To Provide turns for each one player
player1_turn = lambda {
  system 'clear'

  unless !(winner == 0)

    game_trial.display_board
    puts "\t It's #{game_trial.player1}'s turn \n"
    puts "\t Reminder: You're 'X'"
    x_selected = gets.chomp.to_i
    move_repeated = game_trial.check_moves_repeated(x_selected)
    unless (((1..9).include? x_selected) && !move_repeated)
      puts "\t Invalid, please select a number between 1 to 9 and don' repeat them."
      x_selected = gets.chomp.to_i
      move_repeated = game_trial.check_moves_repeated(x_selected)
    end
    game_trial.save_marker_player1(x_selected)
    game_trial.update_board(x_selected, "X")
    game_trial.moves_used(x_selected)
    system 'clear'
    game_trial.display_board
    sleep(1)
  else
    next
  end
}

player2_turn = lambda {
  system 'clear'
  unless !(winner == 0)

    game_trial.display_board
    puts "\t It's #{game_trial.player2}'s turn \n"
    puts "\t Reminder: You're 'O'"
    o_selected = gets.chomp.to_i
    move_repeated = game_trial.check_moves_repeated(o_selected)
    until ((1..9).include? o_selected) && !move_repeated
      puts "\t Invalid, please select a number between 1 to 9 and don' repeat them."
      o_selected = gets.chomp.to_i
      move_repeated = game_trial.check_moves_repeated(o_selected)
    end
    game_trial.save_marker_player2(o_selected)
    game_trial.update_board(o_selected, "O")
    game_trial.moves_used(o_selected)
    system 'clear'
    game_trial.display_board
    sleep(1)
  else
    next
  end
}

# Compare results to see if there are winner so far
check_winner = lambda {

  game_trial.player1_marker.each do |value|
    if combinations_likely_to_win.include?(value)
      winner = 1
    end
  end

  game_trial.player2_marker.each do |value|
    if combinations_likely_to_win.include?(value)
      winner = 2
    end
  end
}

# To Check out what is the game result
players_finish_turn = lambda {
  system 'clear'

  puts "\t
  \t░██████╗░░█████╗░███╗░░░███╗███████╗  ░█████╗░██╗░░░██╗███████╗██████╗░
  \t██╔════╝░██╔══██╗████╗░████║██╔════╝  ██╔══██╗██║░░░██║██╔════╝██╔══██╗
  \t██║░░██╗░███████║██╔████╔██║█████╗░░  ██║░░██║╚██╗░██╔╝█████╗░░██████╔╝
  \t██║░░╚██╗██╔══██║██║╚██╔╝██║██╔══╝░░  ██║░░██║░╚████╔╝░██╔══╝░░██╔══██╗
  \t╚██████╔╝██║░░██║██║░╚═╝░██║███████╗  ╚█████╔╝░░╚██╔╝░░███████╗██║░░██║
  \t░╚═════╝░╚═╝░░╚═╝╚═╝░░░░░╚═╝╚══════╝  ░╚════╝░░░░╚═╝░░░╚══════╝╚═╝░░╚═╝ \n \n"

  case winner
  when 1
    puts "\t#{game_trial.player1} won the Ruby's Tic Tac Toe\t"
  when 2
    puts "\t#{game_trial.player2} won the Ruby's Tic Tac Toe\t"
  else
    puts "\tIt's a TIE \n \n \tGame ove"
  end
}

# Game Loop
while game_state
  if (winner != 0) || (game_trial.get_moves_used.length > 7)
    game_state = false
    break
  else
    player1_turn.call
    check_winner.call
    puts "Iterator: #{iterator}"
    puts "Movimientos usados: #{game_trial.get_moves_used.length}"
    player2_turn.call
    check_winner.call
  end
end

# Show results when game finish
players_finish_turn.call
