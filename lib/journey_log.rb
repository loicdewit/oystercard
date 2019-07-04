require 'Journey'

class JourneyLog

  attr_reader :journey_history

  def initialize
    @journey_history = []
    current_journey
  end

  def start(station)
    @current_journey.add_entry_station(station)
  end

  def finish(station)
    @current_journey.add_exit_station(station)
    update_journey_history
  end

  def journeys
    @journey_history.each do |journey|
      puts "#{journey[:begin]} --> #{journey[:end]}"
    end
  end

  def calc_fare
    @current_journey.fare
  end

  private

  def update_journey_history
    @journey_history << @current_journey.journey
  end

  def current_journey
    if @currnt_journey == nil
      @current_journey = Journey.new
    else
      @current_journey
    end
  end
end
