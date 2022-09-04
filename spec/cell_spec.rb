require 'rspec'
require './lib/cell'

RSpec.describe Cell do 
    describe '#initialize' do 
        before(:each) do 
            @cell = Cell.new("B4")
        end 
        it 'exists' do 
            expect(@cell).to be_a Cell
        end 
        it 'has a coordinate' do 
            expect(@cell.coordinate).to eq('B4')
        end 
        it 'has no ship to start' do 
            expect(@cell.ship).to eq(nil)
        end 
        it 'is empty to start' do 
            expect(@cell.empty?).to eq(true)
        end 
        it 'hasnt been fired upon' do 
            expect(@cell.fired_upon?).to eq(false)
        end 
    end 
    describe '#place_ship' do 
        before(:each) do 
            @cell = Cell.new("B4")
            @cruiser = Ship.new("Cruiser", 3)
            @cell.place_ship(@cruiser)
        end 
        it 'places ship into cell' do 
            expect(@cell.ship).to eq(@cruiser)
        end 
        it 'is no longer empty after placed' do 
            expect(@cell.empty?).to eq(false)
        end 
    end 
    describe '#fire_upon' do 
        before(:each) do 
            @cell = Cell.new("B4")
            @cruiser = Ship.new("Cruiser", 3)
        end 
        it 'becomes fired upon' do 
            @cell.place_ship(@cruiser)
            expect(@cell.fired_upon?).to eq(false)
            @cell.fire_upon 
            expect(@cell.fired_upon?).to eq(true)
        end 
        it 'makes ship get hit' do 
            @cell.place_ship(@cruiser)
            @cell.fire_upon 
            expect(@cruiser.health).to eq(2)
        end 
        it 'doesnt error if no ship' do 
            @cell.fire_upon
            expect(@cell).to be_a Cell 
        end    
    end 
    describe '#render' do 
        before(:each) do 
            @cell = Cell.new("B4")
            @cruiser = Ship.new("Cruiser", 3)
        end 
        it 'knows when cell hasnt been fired on' do 
            expect(@cell.render).to eq('.')
        end 
        it 'knows when cell has no ship when fired' do 
            @cell.fire_upon
            expect(@cell.render).to eq('M')
        end 
        it 'knows when cell has ship and fired' do 
            @cell.place_ship(@cruiser)
            @cell.fire_upon
            expect(@cell.render).to eq('H')
        end 
        it 'knows if its ship was sunk' do 
            @cell.place_ship(@cruiser)
            @cell.fire_upon
            @cruiser.hit
            @cruiser.hit
            expect(@cell.render).to eq('X')
        end 
    end 
end 