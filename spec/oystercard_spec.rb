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
      expect(subject.deduct(10)).to eq 0
    end
  end

  describe '#touch_in' do
    it "raises error if balance is less than £1" do
      station = double(:station, name: "Station", zone: "1")
      expect { subject.touch_in(station) }.to raise_error "Your Oystercard has less than £#{subject.minimum}"
    end
  end

  describe '#touch_out' do
    it 'Deducts correct amount' do
      station = double(:station, name: "Victoria", zone: "1")
      station1 = double(:station, name: "Aldgate East", zone: "1")
      journey = double(:journey)
      allow(journey).to receive(:add_entry_station).and_return(false)
      allow(journey).to receive(:fare).and_return(1)
      allow(journey).to receive(:add_exit_station)
      allow(journey).to receive(:journey)
      subject.top_up(5)
      subject.touch_in(station)
      expect {subject.touch_out(station1)}. to change{subject.balance}.by(-1)
    end
  end
end
