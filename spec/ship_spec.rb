require 'rspec'
require './lib/ship'

RSpec.describe do 
    describe '#initialize' do 
        before(:each) do 
            @cruiser = Ship.new('Cruiser', 3)
        end 
        it 'has a name' do 
            expect(@cruiser.name).to eq('Cruiser')
        end 
        it 'has a length' do 
            expect(@cruiser.length).to eq(3)
        end 
        it 'has a health status' do 
            expect(@cruiser.health).to eq(3)
        end 
        it 'hasnt sunk' do 
            expect(@cruiser.sunk?).to eq(false)
        end 
    end 
    describe '#hit' do 
        before(:each) do 
            @cruiser = Ship.new('Cruiser', 3)
        end 
        it 'loses health when hit' do 
            expect(@cruiser.health).to eq(3)
            @cruiser.hit 
            expect(@cruiser.health).to eq(2)
        end 
        it 'sinks when health is 0' do 
            @cruiser.hit
            @cruiser.hit
            @cruiser.hit

            expect(@cruiser.health).to eq(0)
            expect(@cruiser.sunk?).to eq(true)
        end 
    end
end 

