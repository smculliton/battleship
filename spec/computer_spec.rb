require './lib/computer'

RSpec.describe Computer do 
    describe '#adjacent_coordinates' do 
        it 'returns adjacent coordinates to given coordinate' do 
            comp = Computer.new 
            expect(comp.adjacent_coordinates('B2')).to eq(['B1','B3','C2','A2'])
        end
    end
end

