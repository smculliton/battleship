require './lib/ship'
require './lib/board'
require 'pry'

class Computer  
    attr_reader :board, :last_hit
    attr_accessor :ship1, :ship2, :ships

    def initialize(human = false)
        @ship1 = Ship.new('Cruiser', 3)
        @ship2 = Ship.new('Submarine', 2)
        @ships = [@ship1, @ship2]
        @board = Board.new 
        @last_hit = nil 
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
        return shoot_randomly(board) if last_hit == nil 
        return shoot_near_hit if last_hit != nil 
    end

    def shoot_randomly(board)
        coordinate = ('A'..'Z').to_a.first(@board.height).sample.concat(rand(1..@board.width).to_s)

        return shoot(board) if !board.valid_coordinate?(coordinate) || board.cells[coordinate].fired_upon?

        @last_hit = coordinate if hit?(coordinate)
        board.cells[coordinate].fire_upon
        # binding.pry
        coordinate 
    end

    def shoot_near_hit(board)


        return shoot_near_hit(board) if !board.valid_coordinate?(coordinate) || board.cells[coordinate].fired_upon?

        @last_hit = coordinate if hit?(coordinate)
        board.cells[coordinate].fire_upon
        coordinate 
    end

    def hit?(coordinate)
        !board.cells[coordinate].empty?
    end

    def adjacent_coordinates(coordinate)
        #B2 => [A2,C2,B1,B3]
        adj_coords = []
        split_coord = coordinate.split(//, 2)

        adj_coords << split_coord[0].concat((split_coord[1].to_i - 1).to_s)
        adj_coords << split_coord[0].concat((split_coord[1].next).to_s)
        adj_coords << split_coord[0].next.concat(split_coord[1])
        binding.pry 
        adj_coords << ('A'..'Z').to_a[('A'..'Z').to_a.index(split_coord[0]) - 1].concat(split_coord[1])

    end
end 