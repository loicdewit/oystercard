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
    if fare_check
      return compute_fare()
    else
      return Oystercard::PENALTY
    end
  end

  def fare_check
    @journey[:begin] != nil && @journey[:end] != nil
  end

  private

  def compute_fare
    start_zone = @journey[:begin].zone
    end_zone = @journey[:end].zone
    fare = Oystercard::MINIMUM + (start_zone - end_zone).abs
  end
end
