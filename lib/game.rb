require './lib/board'
require './lib/main_menu'
require './lib/user'
require './lib/computer'
require 'pry'


class Game
    attr_reader :player, :comp, :players

    def initialize
        @player = User.new
        @comp = Computer.new
        @players = [@player, @comp]
    end 

    def start
        main_menu

        command = ''
        until command == 'q' || command == 'p' do
            print '(?) - '
            command = gets.chomp
            return if command.downcase == 'q'
            break if command.downcase == 'p'
            return change_board if command.downcase == 'b'
            return change_ships if command.downcase == 's'
            puts ' '
            puts '-- invalid command --'
            puts ' '
        end

        player.place_ships 
        comp.place_ships
        new_turn
    end 

    def new_turn
        puts `clear`
        puts "=============COMPUTER BOARD=============\n"
        puts comp.board.render
        puts ' '
        puts "==============PLAYER BOARD==============\n"
        puts player.board.render(true)
        puts ' '

        player_shot = player.shoot(comp.board)
        comp_shot = comp.shoot(player.board)

        if player.ships.all? { |ship| ship.sunk? }
            end_game("I")
        elsif comp.ships.all? { |ship| ship.sunk? }
            end_game("YOU")
        end 

        puts "Your shot on #{player_shot} was a #{shot_result(comp.board.cells[player_shot])}"
        puts "My shot on #{comp_shot} was a #{shot_result(player.board.cells[comp_shot])}"
        gets.chomp 

        new_turn
    end 

    def end_game(player)
        boat_explosion
        puts"\n\n\n"
        puts "               ( O===----- #{player} WON!! -----===O )"
        puts ' '
        puts ' '
        puts 'Press ENTER to return'
        gets.chomp 
        new_game = Game.new
        new_game.start
    end 

    def shot_result(shot)
        return 'miss' if shot.empty?
        return 'hit, and the boat sinks to a watery grave!' if shot.empty? == false && shot.ship.sunk?
        return 'hit' if shot.empty? == false 
    end

    def boat_explosion
            puts `clear`
            i = 0
            5.times do 
                now = Time.now.sec
                #its getting stuck when the minute changes bc (now = :59) & (now + 1) is a second that can't exist
                h = 0
                loop do 
                    h += 1
                    break if h == 800000
                    if Time.now.sec >= (now + 1) || Time.now.sec < 3
                        puts "\n\n\n\n\n\n\n\n\n" +
                        '                                    __/___            
                              _____/______|           
                      _______/_____\_______\_____     
                      \              < < <       |    
              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~' if i == 0
                        print '..' if i == 1
                        print '..' if i == 2 
                        print '..' if i == 3
                        puts`clear` + "\n\n" + '                               ____
                        __,-~~/~    `---.
                      _/_,---(      ,    )
                  __ /        <    /   )  \___
        - ------===;;;;====------------------===;;;===----- -  -
                     \/  ~"~"~"~"~"~\~"~)~"/
                     (_ (   \  (     >    \)
                      \_( _ <         >_>`
                         ~ `-i` ::>|--"
                             I;|.|.|
                            <|i::|i|`.
                           (` ^`"`-` ")
            ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~' if i == 4
                        
                    i += 1
                    break
                end 
            end
        end
    end

    def change_board
        puts `clear`
        puts 'Board width? (Enter 1 - 20)'
        width = gets.chomp.to_i 
        until (1..20).include?(width)
            puts 'Please enter a number between 1 and 20'
            width = gets.chomp.to_i 
        end 
        puts 'Board height? (Enter 1 - 20)'
        height = gets.chomp.to_i
        until (1..20).include?(height)
            puts 'Please enter a number between 1 and 20'
            height = gets.chomp.to_i 
        end 
        player.board.spawn_board(width, height)
        comp.board.spawn_board(width, height)
        start
    end 

    def change_ships
        puts `clear`
        puts 'How many ships do you want for this game? (Enter 1 - 4)'
        ship_count = gets.chomp.to_i
        until (1..4).include?(ship_count)
            puts 'Please enter a number between 1 and 4:'
            ship_count = gets.chomp.to_i
        end

        @player.ships = []
        @comp.ships = []

        ship_count.times do |i|
            puts "Enter Ship #{i+1} Name:"
            name = gets.chomp
            puts "Enter #{name} length (1-#{[@player.board.width, @player.board.height].max}):"
            length = gets.chomp.to_i
            until (1..([@player.board.width, @player.board.height].max)).include?(length)
                puts "Invalid length. Please enter a number between 1 and #{[@player.board.width, @player.board.height].min}"
                length = gets.chomp.to_i
            end
            @player.ships << Ship.new(name, length)
            @comp.ships << Ship.new(name, length)
        end
        start
    end



end 