require 'station'

RSpec.describe Station do

  describe '#initialize' do
    it 'asks for a station zone' do
      victoria = Station.new('Victoria', '1')
      expect(victoria.zone).to eq '1'
    end
    it 'asks for a station name' do
      victoria = Station.new('Victoria', '1')
      expect(victoria.name).to eq 'Victoria'
    end
  end
  
end
