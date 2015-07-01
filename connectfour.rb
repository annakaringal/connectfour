require_relative 'board'

module View
  def self.display_game (board)
    clear_screen
    board_strs = board.to_s.split("\n")

    puts board_strs.map { |row| '| ' + row + ' |' }.join("\n")
    puts "- 1 2 3 4 5 6 7 -"
  end

  def self.clear_screen
    print "\e[H\e[2J"
  end

end

class ConnectFourGame
  def initialize
    @game = ConnectFourBoard.new
  end

  def convert_input(input)
    input -= 1
  end

  def play
    counter = 0
    player = ""

    loop do
      View.display_game(@game)

      player = (counter % 2 == 0 ? "X" : "O")
      puts "PLAYER #{player}: which column would you like to play?"
      col = convert_input(gets.chomp.to_i)

      unless col >= ConnectFourBoard::WIDTH && col < 0 || @game.col_full?(col)
        @game.place(player, col)
        counter += 1
        break if @game.win? || @game.board_full?
      else
        puts "Sorry. You can't choose that column. Please try again."
      end
      
    end
    unless @game.board_full?
      View.display_game(@game)
      puts "CONGRATULATIONS, PLAYER #{player}! You won!"
    else
      puts "IT'S A TIE... the board is full. No more moves can be made!"
    end

  end

end

game = ConnectFourGame.new
game.play

