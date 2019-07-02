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
    @current_journey = {}
  end

  def top_up(load)
    fail "Card limit is #{LIMIT}, your balance is #{@balance}" if limit_exceeded?(load)
    @balance += load
  end

  def deduct(amount)
    @balance -= amount
  end

  def in_journey?
    @current_journey[:begin] != nil && @current_journey[:end] == nil
  end

  def touch_in(station)
    fail "Your Oystercard has less than £#{MINIMUM}" if limit_reached?
    @current_journey = {begin: station}
  end

  def touch_out(amount, station)
    deduct(amount)
    update_journey_history(station)
  end

  private

  def update_journey_history(station)
    @current_journey[:end] = station
    @journey_history << @current_journey
  end

  def limit_exceeded?(load)
    load > LIMIT - @balance
  end

  def limit_reached?
    @balance < MINIMUM
  end
end
