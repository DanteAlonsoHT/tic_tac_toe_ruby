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

sleep(1)

game_trial.start

def display_board(game_trial)
  (0..2).each do |i|
    puts "\t +---+---+---+"
    print "\t"
    (0..7).each do |j|
      print ' | ' unless j.odd?
      print game_trial.return_game_board[i][((j * 3) / 7).to_i] unless j.even?
    end
    puts i == 2 ? "\n\t +---+---+---+" : "\t"
  end
end

puts "
  \t ██╗░░░░░░█████╗░░█████╗░██████╗░██╗███╗░░██╗░██████╗░░░░░░░░░░
  \t ██║░░░░░██╔══██╗██╔══██╗██╔══██╗██║████╗░██║██╔════╝░░░░░░░░░░
  \t ██║░░░░░██║░░██║███████║██║░░██║██║██╔██╗██║██║░░██╗░░░░░░░░░░
  \t ██║░░░░░██║░░██║██╔══██║██║░░██║██║██║╚████║██║░░╚██╗░░░░░░░░░
  \t ███████╗╚█████╔╝██║░░██║██████╔╝██║██║░╚███║╚██████╔╝██╗██╗██╗
  \t ╚══════╝░╚════╝░╚═╝░░╚═╝╚═════╝░╚═╝╚═╝░░╚══╝░╚═════╝░╚═╝╚═╝╚═╝"

sleep(1)

combinations_likely_to_win = [[1, 2, 3], [2, 5, 8], [3, 6, 9], [4, 5, 6], [1, 4, 7], [1, 5, 9], [3, 5, 7], [7, 8, 9]]

combinations_likely_to_win.each do |values_to_win|
  combinations_likely_to_win += [values_to_win.rotate(2)]
  combinations_likely_to_win += [values_to_win.rotate(-2)]
end

winner = 0
game_state = true

def check_update_board(games_class, move, print_to_dashboard)
  move_repeated = games_class.check_moves_repeated(move)
  until ((1..9).include? move) && !move_repeated
    puts "\t Invalid, please select a number between 1 to 9 and don' repeat them."
    move = gets.chomp.to_i
    move_repeated = games_class.check_moves_repeated(move)
  end
  games_class.update_board(move, print_to_dashboard)
  games_class.moves_used(move)
end

player1_turn = lambda {
  system 'clear'

  next unless winner.zero?

  display_board(game_trial)
  puts "\t It's #{game_trial.player1}'s turn \n"
  puts "\t Reminder: You're 'X'"
  x_selected = gets.chomp.to_i
  check_update_board(game_trial, x_selected, 'X')
  game_trial.save_marker_player1(x_selected)
  system 'clear'
  display_board(game_trial)
}

player2_turn = lambda {
  system 'clear'
  next unless winner.zero?

  display_board(game_trial)
  puts "\t It's #{game_trial.player2}'s turn \n"
  puts "\t Reminder: You're 'O'"
  o_selected = gets.chomp.to_i
  check_update_board(game_trial, o_selected, 'O')
  game_trial.save_marker_player2(o_selected)
  system 'clear'
  display_board(game_trial)
}

check_winner = lambda {
  game_trial.player1_marker.each do |value|
    winner = 1 if combinations_likely_to_win.include?(value)
  end

  game_trial.player2_marker.each do |value|
    winner = 2 if combinations_likely_to_win.include?(value)
  end
}

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

while game_state
  if (winner != 0) || (game_trial.read_moves_used.length > 8)
    game_state = false
    break
  else
    player1_turn.call
    check_winner.call
    player2_turn.call
    check_winner.call
  end
end

players_finish_turn.call
