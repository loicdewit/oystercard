require 'oystercard'

RSpec.describe Oystercard do
  describe '#initialize' do
    it 'Sets balance to zero' do
      expect(subject.balance).to eq(0)
    end
  end
  describe '#top_up' do
    it "adds money to your card" do
      subject.top_up(5)
      expect(subject.balance).to eq(5)
    end
    it "prevents card from exceeding maximum amount of pounds" do
      allowed = (subject.limit - subject.balance)
      test_amount =  allowed + 1
      expect { subject.top_up(test_amount) }.to raise_error "Card limit is #{subject.limit}, your balance is #{subject.balance}"
    end
  end
  describe '#deduct' do
    it "deduces money from your card" do
      subject.top_up(10)
      expect(subject.deduce(10)).to eq 0
    end
  end
end
