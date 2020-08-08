require 'board'
require 'save_handler'
require 'menus/main_menu'

class GameMenu

  def initialize(board = Board.new, save_index = nil)
    @board = board
    @save_index = save_index
    play
  end

  private def play
    loop do
      #display board
      system 'clear'
      puts "Enter 'save' to save and exit"
      puts "Enter 'back' to exit with ought saving"
      puts ''
      @board.display

      input = gets.chomp.downcase
      if input.eql? 'save'
        SaveHandler.save(@board.word, @board.letters, @board.guesses, @save_index)
        MainMenu.start
        return
      elsif input.eql? 'back'
        MainMenu.start
        return
      end

      state = @board.update(input)

      next if state == 0

      #display win
      if state == 1
        system 'clear'
        @board.display
        puts "win!"

        SaveHandler.delete(@save_index) unless @save_index.nil?
        break
      end
      #display loss
      if state == -1
        system 'clear'
        @board.display
        puts "game over"
        puts "word was #{@board.word}"

        SaveHandler.delete(@save_index) unless @save_index.nil?
        break
      end
    end
  end
end