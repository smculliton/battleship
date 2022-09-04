require 'rspec'
require './lib/board'

RSpec.describe Board do 
    describe '#initialize' do 
        before(:each) do 
            @board = Board.new 
        end 
        it 'creates a hash' do 
            expect(@board.cells).to be_a Hash 
        end 
        it 'hash has 16 key/value pairs' do 
            expect(@board.cells.length).to eq(16)
        end 
        it 'keys are cell objects' do
            # tested = @board.cells.values.all? { |cell| cell.class == Class }
            # expect(tested).to be(true)
            expect(@board.cells['A1']).to be_an_instance_of Cell
        end 
    end 
    describe '#valid_coordinate?' do 
        it 'says if a coordinate is valid' do 
            board = Board.new 
            expect(board.valid_coordinate?('A1')).to eq(true)
            expect(board.valid_coordinate?('E1')).to eq(false)
        end 
    end 
    describe '#valid_placement?' do 
        before(:each) do 
            @board = Board.new
            @cruiser = Ship.new("Cruiser", 3)
            @submarine = Ship.new("Submarine", 2)
        end 
        it 'makes sure array length = ship length' do 
            expect(@board.valid_placement?(@cruiser, ["A1",'A2'])).to eq(false)
            expect(@board.valid_placement?(@submarine, ["A1",'A2','A3'])).to eq(false)
        end 
        it 'makes sure coordinates are consecutive' do 
            expect(@board.valid_placement?(@cruiser, ["A1", "A2", "A4"])).to eq(false)
            expect(@board.valid_placement?(@submarine, ["A1", "C1"])).to eq(false)
            expect(@board.valid_placement?(@cruiser, ["A3", "A2", "A1"])).to eq(false)
            expect(@board.valid_placement?(@submarine, ["C1", "B1"])).to eq(false)
        end 
        it 'coordinates cant be diagonal' do
            expect(@board.valid_placement?(@cruiser, ["A1", "B2", "C3"])).to eq(false)
            expect(@board.valid_placement?(@submarine, ["C2", "D3"])).to eq(false)
        end 
        it 'returns true if valid placement' do 
            expect(@board.valid_placement?(@submarine, ["A1", "A2"])).to eq(true)
            expect(@board.valid_placement?(@cruiser, ["B1", "C1", "D1"])).to eq(true)
        end
        it 'returns false if a ship is already placed' do 
            @board.place(@cruiser, ['A1','A2','A3'])
            expect(@board.valid_placement?(@submarine, ['A1','B1'])).to eq(false)
        end 
    end 
    describe '#place' do 
        before(:each) do 
            @board = Board.new
            @cruiser = Ship.new("Cruiser", 3)
        end 
        it 'places a ship' do 
            @board.place(@cruiser, ['A1','A2','A3'])
            cell_1 = @board.cells['A1']
            cell_2 = @board.cells['A2']
            cell_3 = @board.cells['A3']

            expect(cell_1.ship).to eq(@cruiser)
            expect(cell_2.ship).to eq(@cruiser)
            expect(cell_3.ship).to eq(@cruiser)
            expect(cell_1.ship == cell_2.ship).to eq(true)
        end
    end     
    describe '#render' do 
        before(:each) do 
            @board = Board.new
            @cruiser = Ship.new("Cruiser", 3)
            @board.place(@cruiser, ["A1", "A2", "A3"])
        end 
        it 'renders empty if ships is false' do 
            expect(@board.render).to eq("  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n")
        end 
        it 'renders ships if true' do 
            expect(@board.render(true)).to eq("  1 2 3 4 \nA S S S . \nB . . . . \nC . . . . \nD . . . . \n")
        end 
    end
    describe '#spawn_board' do 
        before(:each) do 
            @board = Board.new
        end
        xit 'makes a board of any width/height' do 
            @board.spawn_board(2,4)
            expect(@board.cells).to eq({
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
            })
        end
    end
end 