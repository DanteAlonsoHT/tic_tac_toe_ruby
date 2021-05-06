#!/usr/bin/env ruby

class Game
  def start
    system 'clear'

    # Create Variable to Tic tac toe's board
    @game_board = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
  end

  # Display the Tic tac toe's board
  def display_board
    (0..2).each do |i|
      puts ' +---+---+---+'
      (0..7).each do |j|
        print ' | ' if j.even?
        print @game_board[i][((j * 3) / 7).to_i] if j.odd?
      end
      puts i == 2 ? "\n +---+---+---+" : nil
    end
  end
end

# Class to include attributes/methods of Game and saving names for each player
class Players < Game
  attr_reader :player1, :player2

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
  end
end

system 'clear'

puts "Welcome to an amazing game :D -> Ruby's Tic Tac Toe"
puts "Please, give me two names to each player \n \n"

puts 'First player name: '
player1 = gets.chomp.capitalize

while player1.empty?
  puts 'First player name: '
  player1 = gets.chomp.capitalize
end

puts 'Second player name: '
player2 = gets.chomp.capitalize

while player2.empty?
  puts 'Second player name: '
  player2 = gets.chomp.capitalize
end

game_trial = Players.new(player1, player2)

puts "\n #{game_trial.player1} is going to play 'X', and #{game_trial.player2} will play 'O'"
puts "Let's start"

sleep(3)

game_trial.start

# Variable can control the iterations
number_turn = 0

# To Provide turns for each one player
players_turn = lambda {
  system 'clear'

  game_trial.display_board
  puts "It's #{game_trial.player1}'s turn \n"
  puts "Reminder: You're 'X"
  puts 'Please select a a number between 1 to 9 according to the board.'
  x_selected = gets.chomp.to_i
  until (1..9).include? x_selected
    puts 'Invalid, please select a number between 1 to 9.'
    x_selected = gets.chomp.to_i
  end

  system 'clear'

  game_trial.display_board
  puts "It's #{game_trial.player2}'s turn \n"
  puts "Reminder: You're 'O"
  puts 'Please select a a number between 1 to 9 according to the board.'
  o_selected = gets.chomp.to_i
  until (1..9).include? o_selected
    puts 'Invalid, please select a number between 1 to 9.'
    o_selected = gets.chomp.to_i
  end
  number_turn += 1
}

# To Check out what is the game result
players_finish_turn = lambda {
  system 'clear'
  random_result = rand(1...4)

  case random_result
  when 1
    puts "#{game_trial.player1} won the Ruby's Tic Tac Toe"
  when 2
    puts "#{game_trial.player2} won the Ruby's Tic Tac Toe"
  else
    puts "It's a TIE \n \n Game over"
  end
}

# Game Loop
players_turn.call while number_turn < 4

# Show results when game finish
players_finish_turn.call
