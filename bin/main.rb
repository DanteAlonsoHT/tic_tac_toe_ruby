#!/usr/bin/env ruby

class Game
  @@moves_used = []
  @move_definetily_repeated = false
  def initialize(_player1, _player2)
    @n = 0
  end

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

  def moves_used(move_used)
    if !move_used.nil?
      @@moves_used[@n] = move_used
      @n += 1
    end
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
    @@marker
  end

  def player2_marker
    @@marker2
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

# Combinations to win
combinations_likely_to_win = [[1, 2, 3], [2, 5, 8], [3, 6, 9], [4, 5, 6], [1, 4, 7], [1, 5, 9], [3, 5, 7], [7, 8, 9]]

game_trial.start

# Variable can control the iterations
iterator = 0
winner = 0
game_state = true
move_repeated = false

# To Provide turns for each one player
player1_turn = lambda {
  system 'clear'

  unless !(iterator == 0)

    game_trial.display_board
    puts "It's #{game_trial.player1}'s turn \n"
    puts "Reminder: You're 'X'"
    x_selected = gets.chomp.to_i
    move_repeated = game_trial.check_moves_repeated(x_selected)
    unless (((1..9).include? x_selected) && !move_repeated)
      puts "Invalid, please select a number between 1 to 9 and don' repeat them."
      x_selected = gets.chomp.to_i
      move_repeated = game_trial.check_moves_repeated(x_selected)
    end
    game_trial.save_marker_player1(x_selected)
    game_trial.moves_used(x_selected)
    print game_trial.player1_marker
    puts nil
    print game_trial.get_moves_used
    sleep(1)
  else
    next
  end
}

player2_turn = lambda {
  system 'clear'
  unless !(iterator == 0)

    game_trial.display_board
    puts "It's #{game_trial.player2}'s turn \n"
    puts "Reminder: You're 'O'"
    o_selected = gets.chomp.to_i
    move_repeated = game_trial.check_moves_repeated(o_selected)
    until ((1..9).include? o_selected) && !move_repeated
      puts "Invalid, please select a number between 1 to 9 and don' repeat them."
      o_selected = gets.chomp.to_i
      move_repeated = game_trial.check_moves_repeated(o_selected)
    end
    game_trial.save_marker_player2(o_selected)
    game_trial.moves_used(o_selected)
    print game_trial.player2_marker
    puts nil
    print game_trial.get_moves_used
    sleep(1)
  else
    next
  end
}

# Compare results to see if there are winner so far
check_winner = lambda {
  combinations_likely_to_win.each do |i|
    iterator = i if (i == game_trial.player1_marker) || (i == game_trial.player2_marker)
  end
  if iterator == game_trial.player1_marker
    winner = 1
  elsif iterator == game_trial.player2_marker
    winner = 2
  end
}

# To Check out what is the game result
players_finish_turn = lambda {
  system 'clear'

  case winner
  when 1
    puts "#{game_trial.player1} won the Ruby's Tic Tac Toe"
  when 2
    puts "#{game_trial.player2} won the Ruby's Tic Tac Toe"
  else
    puts "It's a TIE \n \n Game over"
  end
}

# Game Loop
while game_state
  if (iterator == game_trial.player1_marker) || (iterator == game_trial.player2_marker) || (game_trial.get_moves_used.length > 7)
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
