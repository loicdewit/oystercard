require 'oystercard'


RSpec.describe Oystercard do
  describe '#initialize' do
    it 'Sets balance to zero' do
      expect( subject.balance).to eq(0)
    end
  end
end
