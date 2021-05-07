#!/usr/bin/env ruby

require_relative '../lib/game'
require_relative '../lib/players'

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

puts 'First player name: '
player1 = gets.chomp.capitalize

while player1.empty?
  puts "\t Invalid name, try again!
  \n First player name: "
  player1 = gets.chomp.capitalize
end

puts 'Second player name: '
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

# Create permutations
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

  next unless winner.zero?

  game_trial.display_board
  puts "\t It's #{game_trial.player1}'s turn \n"
  puts "\t Reminder: You're 'X'"
  x_selected = gets.chomp.to_i
  move_repeated = game_trial.check_moves_repeated(x_selected)
  unless ((1..9).include? x_selected) && !move_repeated
    puts "\t Invalid, please select a number between 1 to 9 and don' repeat them."
    x_selected = gets.chomp.to_i
    move_repeated = game_trial.check_moves_repeated(x_selected)
  end
  game_trial.save_marker_player1(x_selected)
  game_trial.update_board(x_selected, 'X')
  game_trial.moves_used(x_selected)
  system 'clear'
  game_trial.display_board
  sleep(1)
}

player2_turn = lambda {
  system 'clear'
  next unless winner.zero?

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
  game_trial.update_board(o_selected, 'O')
  game_trial.moves_used(o_selected)
  system 'clear'
  game_trial.display_board
  sleep(1)
}

# Compare results to see if there are winner so far
check_winner = lambda {
  game_trial.player1_marker.each do |value|
    winner = 1 if combinations_likely_to_win.include?(value)
  end

  game_trial.player2_marker.each do |value|
    winner = 2 if combinations_likely_to_win.include?(value)
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
  if (winner != 0) || (game_trial.read_moves_used.length > 7)
    game_state = false
    break
  else
    player1_turn.call
    check_winner.call
    puts "Iterator: #{iterator}"
    puts "Movimientos usados: #{game_trial.read_moves_used.length}"
    player2_turn.call
    check_winner.call
  end
end

# Show results when game finish
players_finish_turn.call
