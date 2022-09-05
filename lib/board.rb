require 'pry'
require './lib/cell'

class Board 
    attr_reader :cells, :width, :height 

    def initialize
        @cells = {
            "A1" => Cell.new('A1'),
            "A2" => Cell.new('A2'),
            "A3" => Cell.new('A3'),
            "A4" => Cell.new('A4'),
            "B1" => Cell.new('B1'),
            "B2" => Cell.new('B2'),
            "B3" => Cell.new('B3'),
            "B4" => Cell.new('B4'),
            "C1" => Cell.new('C1'),
            "C2" => Cell.new('C2'),
            "C3" => Cell.new('C3'),
            "C4" => Cell.new('C4'),
            "D1" => Cell.new('D1'),
            "D2" => Cell.new('D2'),
            "D3" => Cell.new('D3'),
            "D4" => Cell.new('D4')
        }
        @width = 4
        @height = 4
    end 

    def spawn_board(width, height)
        @cells = {}
        @width = width 
        @height = height
        height.times do |i1|
            width.times do |i2|
                letter = ('A'..'Z').to_a[i1]
                number = i2 + 1
                @cells["#{letter}#{number}"] = Cell.new("#{letter}#{number}")
            end
        end
    end

    def valid_coordinate?(coordinate)
        @cells.keys.include?(coordinate)
    end 

    def valid_placement?(ship, cells)
        return false unless cells.all? { |cell| @cells.keys.include?(cell) }
        
        letters = cells.map { |cell| cell[0] }
        numbers = cells.map { |cell| cell.delete(('A'..'Z').to_a.join) }
        return false unless ship.length == cells.length
        # binding.pry
        # return false unless (letters.uniq.length == 1 && numbers == (numbers.min..numbers.max).to_a) || (numbers.uniq.length == 1 && letters == (letters.min..letters.max).to_a)
        return false unless (letters.uniq.length == 1 && numbers.each_cons(2).all? { |num1, num2| num1.next == num2 } ) || (numbers.uniq.length == 1 && letters == (letters.min..letters.max).to_a)
        return false unless cells.all? { |cell| @cells[cell].empty? }
        true 
    end 

    def place(ship, cells)
        cells.each { |cell| @cells[cell].place_ship(ship) } if valid_placement?(ship, cells)
    end 

    def render(ships = false)
        render = ('1'..'100').to_a.first(@width)
        # render = render.join(' ').prepend('  ') unless @width > 10
        render = render.map do |num| 
            if num.to_i < 10
                "#{num} "
            else
                num
            end
        end
        render = render.join.prepend('  ')
        
        
        row_starts = ('A'..'Z').to_a.first(@height)

        row_starts.each do |row|
            render.concat("\n#{row} ")
            @width.times do |i|
                cell = @cells["#{row}#{i + 1}"]
                if ships == true && cell.empty? == false && cell.fired_upon? == false
                    render.concat("S ")
                else
                    render.concat("#{cell.render} ")
                end
            end
        end
        render.concat("\n") 
    end 

end 