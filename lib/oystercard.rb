require 'station'
require 'journey'
require 'journey_log'

class Oystercard

  attr_reader :balance, :journey_log

  LIMIT = 90
  MINIMUM = 1

  def initialize
    @balance = 0
    @journey_log = JourneyLog.new
  end

  def limit
    LIMIT
  end

  def minimum
    MINIMUM
  end

  def top_up(load)
    fail "Card limit is #{LIMIT}, your balance is #{@balance}" if limit_exceeded?(load)
    @balance += load
  end

  def deduct(amount)
    @balance -= amount
  end

  def touch_in(station)
    fail "Your Oystercard has less than £#{MINIMUM}" if limit_reached?
    @journey_log.start(station)
  end

  def touch_out(station)
    journey_log.finish(station)
    deduct(@journey_log.calc_fare)
  end

  private

  def limit_exceeded?(load)
    load > LIMIT - @balance
  end

  def limit_reached?
    @balance < MINIMUM
  end
end
