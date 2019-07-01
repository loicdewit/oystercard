require 'oystercard'

RSpec.describe Oystercard do
  describe '#initialize' do
    it 'Sets balance to zero' do
      expect(subject.balance).to eq(0)
    end
    it 'it initialises in_journey to false' do
      expect(subject).not_to be_in_journey
    end
    it 'it initializes entry_station' do
      expect(subject.entry_station).to eq nil
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
      expect(subject.deduct(10)).to eq 0
    end
  end

  describe '#touch_in' do
    it 'Sets in_journey to true' do
      subject.top_up(subject.minimum)
      expect(subject.touch_in("Station")).to eq true
    end
    it "raises error if balance is less than £1" do
      expect { subject.touch_in("Station") }.to raise_error "Your Oystercard has less than £#{subject.minimum}"
    end
    it "remembers entry station" do
      subject.top_up(5)
      subject.touch_in("Station")
      expect(subject.entry_station).to eq "Station"
    end
  end

  describe '#touch_out' do
    it 'Sets in_journey to false' do
      expect(subject.touch_out(5)).to eq false
    end
    it 'Deducts correct amount' do
      expect {subject.touch_out(5)}. to change{subject.balance}.by(-5)
    end
    it 'Sets entry station to nil' do
      subject.touch_out(5)
      expect(subject.entry_station).to eq nil
    end
  end
end
