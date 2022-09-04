require './lib/ship'
require './lib/board'
require 'pry'

class Computer  
    attr_reader :ship1, :ship2, :ships, :board

    def initialize(human = false)
        @ship1 = Ship.new('Cruiser', 3)
        @ship2 = Ship.new('Submarine', 2)
        @ships = [@ship1, @ship2]
        @board = Board.new 
    end 

    def place_ships
        @ships.each do |ship|
            ship_placement = []
            until @board.valid_placement?(ship, ship_placement)
                ship_placement = []
                ship_placement << @board.cells.keys.sample
                if rand(1..2) == 1
                    (ship.length - 1).times do |i|
                        ship_placement << ship_placement[i][0].concat(ship_placement[i][1].next)  
                    end
                else
                    (ship.length - 1).times do |i|
                        ship_placement << ship_placement[i][0].next.concat(ship_placement[i][1])  
                    end
                end
            end 
            @board.place(ship, ship_placement)
        end 
    end  

    def shoot(board)
        coordinate = ['A','B','C','D'].sample.concat(rand(1..4).to_s)

        if board.cells.keys.include?(coordinate) == false
            return shoot(board)
        elsif board.cells[coordinate].fired_upon?
            return shoot(board)
        end 

        board.cells[coordinate].fire_upon
        coordinate 
    end
end 