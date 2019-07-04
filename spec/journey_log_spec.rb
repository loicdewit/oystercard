require 'journey'
require 'journey_log'

describe JourneyLog do
  describe "#start" do
    it "should enter entry station" do
      station = double(:station)
      fake_journey = double(:journey)
      allow(fake_journey).to receive(:add_entry_station)
      subject.start(station)
      subject.finish(station)
      expect(subject.journeys.pop).to eq ({:begin => station, :end => station})
    end
  end
end
