require './lib/ship'
require './lib/board'
require 'pry'

class User 
    attr_reader :board
    attr_accessor :ship1, :ship2, :ships

    def initialize(human = false)
        @ship1 = Ship.new('Cruiser', 3)
        @ship2 = Ship.new('Submarine', 2)
        @ships = [@ship1, @ship2]
        @board = Board.new 
    end 

    def place_ships
        @ships.each do |ship|
            puts `clear`
            puts 'I have laid out my ships on the grid.'
            puts 'You now need to lay out your two ships.'
            puts 'The Cruiser is three units long and the Submarine is two units long.'
            puts ' '
            puts @board.render(true)
            puts "\nEnter the squares for the #{ship.name} (#{ship.length} squares) separated by one space"
            ship_placement = gets.chomp.upcase.split(' ')
            until ship_placement.length == ship.length && @board.valid_placement?(ship, ship_placement)
                puts 'Invalid entry. Please try again.'
                ship_placement = gets.chomp.upcase.split(' ')
            end
            @board.place(ship, ship_placement)
        end 
    end 

    def shoot(board)
        puts "Enter the coordinate for your shot:\n"
        coordinate = gets.chomp.upcase
        
        until valid_shot?(board, coordinate) do
            if board.cells.keys.include?(coordinate) == false
                puts 'Invalid coordinates. Please try again:'
            elsif board.cells[coordinate].fired_upon?
                puts 'You have already fired on these coordinates. Please try again:'
            end 
            coordinate = gets.chomp.upcase
        end

        board.cells[coordinate].fire_upon
        coordinate
    end

    def valid_shot?(board, coordinate)
        board.cells.keys.include?(coordinate) && board.cells[coordinate].fired_upon? == false
    end

end 