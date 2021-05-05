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

class Players < Game
  attr_reader :player1, :player2

  def initialize(player1, player2)
    super
    @player1 = player1
    @player2 = player2
  end
end
