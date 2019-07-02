require 'oystercard'

RSpec.describe Oystercard do
  describe '#initialize' do
    it 'Sets balance to zero' do
      expect(subject.balance).to eq(0)
    end
    it 'it initialises in_journey to false' do
      expect(subject.in_journey?).to eq false
    end
    it 'it initialises journey_history' do
      expect(subject.journey_history).to eq []
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
    it 'Sets in_journey' do
      subject.top_up(subject.minimum)
      subject.touch_in("Station")
      expect(subject.in_journey?).to eq true
    end
    it "raises error if balance is less than £1" do
      expect { subject.touch_in("Station") }.to raise_error "Your Oystercard has less than £#{subject.minimum}"
    end
    it "it pushes the entry station to current journey" do
      subject.top_up(5)
      subject.touch_in("Victoria")
      expect(subject.current_journey[:begin]).to eq "Victoria"
    end
  end

  describe '#touch_out' do
    it 'Sets in_journey to false' do
      subject.top_up(5)
      subject.touch_in("Victoria")
      subject.touch_out(5, "Algate East")
      expect(subject.in_journey?).to eq false
    end
    it 'Deducts correct amount' do
      subject.top_up(5)
      subject.touch_in("Victoria")
      expect {subject.touch_out(5, "Algate East")}. to change{subject.balance}.by(-5)
    end
    it "it stores the exit station" do
      subject.top_up(5)
      subject.touch_in("Victoria")
      subject.touch_out(5, "Algate East")
      expect(subject.current_journey[:end]).to eq "Algate East"
    end
    it "it stores the whole journey" do
      subject.top_up(5)
      subject.touch_in("Victoria")
      subject.touch_out(5, "Algate East")
      hash = subject.current_journey
      expect(subject.journey_history.pop).to eq hash
    end
  end

  describe '#show_journey_history' do
    it "shows the journey history" do
      subject.top_up(5)
      subject.touch_in("Victoria")
      subject.touch_out(5, "Algate East")
      expect{ subject.show_journey_history }.to output("Victoria --> Algate East\n").to_stdout
    end
  end
end
