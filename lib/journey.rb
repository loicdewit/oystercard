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


# @current_journey
# touch_in - @current_journey = {begin: station}
#
# def in_journey?
#   @current_journey[:begin] != nil && @current_journey[:end] == nil
# end
#
# def update_journey_history(station)
#   @current_journey[:end] = station
#   @journey_history << @current_journey
# end
