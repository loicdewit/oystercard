require 'oystercard'

class Journey

attr_reader :journey, :journey_complete

  def initialize
    @journey = {}
    @journey_complete = false
  end

  def add_entry_station(station)
    @journey[:begin] = station
  end

  def add_exit_station(station)
    @journey[:end] = station
    @journey_complete = true
  end

  def fare
    return Oystercard::MINIMUM if fare_check
    return 6
  end

  def fare_check
    @journey[:begin] != nil && @journey[:end] != nil
  end
end
