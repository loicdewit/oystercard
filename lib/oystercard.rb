require 'station'
require 'journey'

class Oystercard

  attr_reader :balance, :entry_station, :journey_history, :current_journey

  LIMIT = 90
  MINIMUM = 1

  def limit
    LIMIT
  end

  def minimum
    MINIMUM
  end

  def initialize
    @balance = 0
    @journey_history = []
  end

  def top_up(load)
    fail "Card limit is #{LIMIT}, your balance is #{@balance}" if limit_exceeded?(load)
    @balance += load
  end

  def deduct(amount)
    @balance -= amount
  end

  def touch_in(station, journey = Journey.new)
    fail "Your Oystercard has less than £#{MINIMUM}" if limit_reached?
    @current_journey = Journey.new
    @current_journey.add_entry_station(station)
  end

  def touch_out(station)
    deduct(@current_journey.fare)
    @current_journey.add_exit_station(station)
    update_journey_history
  end

  def show_journey_history
    @journey_history.each do |journey|
      puts "#{journey[:begin]} --> #{journey[:end]}"
    end
  end

  private

  def update_journey_history
    @journey_history << @current_journey
  end

  def limit_exceeded?(load)
    load > LIMIT - @balance
  end

  def limit_reached?
    @balance < MINIMUM
  end
end
