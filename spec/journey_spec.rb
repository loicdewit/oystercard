require 'journey'

RSpec.describe Journey do

  describe '#add_entry_station' do
    it 'adds entry station to current_journey' do
      station = double(:station, name: "Victoria", zone: 1)
      subject.add_entry_station(station)
      expect(subject.journey[:begin]).to eq station
    end
  end

  describe '#add_exit_station' do
    it 'adds exit station to current_journey' do
      station = double(:station, name: "Aldgate East", zone: 2)
      subject.add_exit_station(station)
      expect(subject.journey[:end]).to eq station
    end
  end

  describe '#fare' do
    it 'adds up the fare for a journey' do
      station = double(:station, name: "Victoria", zone: 1)
      subject.add_entry_station(station)
      station1 = double(:station, name: "Aldgate East", zone: 2)
      subject.add_exit_station(station1)
      expect(subject.fare).to eq 2
    end
    it 'charges penalty fare if no entry station' do
      station = double(:station, name: "Victoria", zone: 1)
      subject.add_entry_station(station)
      expect(subject.fare).to eq 6
    end
    it 'charges penalty fare if no exit station' do
      station1 = double(:station, name: "Aldgate East", zone: 2)
      subject.add_exit_station(station1)
      expect(subject.fare).to eq 6
    end
  end

  describe '#journey_complete?' do
    it 'confirms journey is complete when exit station added' do
      station = double(:station, name: "Victoria", zone: 1)
      subject.add_entry_station(station)
      station1 = double(:station, name: "Aldgate East", zone: 2)
      subject.add_exit_station(station1)
      expect(subject.journey_complete).to eq true
    end
  end

end
