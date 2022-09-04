require './lib/ship'

class Cell 
    attr_reader :coordinate, :ship 

    def initialize(coordinate)
        @coordinate = coordinate
        @ship = nil 
        @empty = true 
        @fired_upon = false 
    end 

    def render
        return '.' if fired_upon? == false 
        return 'M' if fired_upon? && @ship == nil
        return 'X' if fired_upon? && @ship.sunk?
        return 'H' if fired_upon? && @ship != nil 
    end 

    def place_ship(ship)
        @ship = ship
        @empty = false
    end

    def fire_upon
        @ship.hit if @ship != nil
        @fired_upon = true 
    end 

    def empty?
        @empty
    end 

    def fired_upon?
        @fired_upon
    end 

end 