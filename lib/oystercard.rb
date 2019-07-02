class Oystercard

  attr_reader :balance, :entry_station

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
    @entry_station
  end

  def top_up(load)
    fail "Card limit is #{LIMIT}, your balance is #{@balance}" if limit_exceeded?(load)
    @balance += load
  end

  def deduct(amount)
    @balance -= amount
  end

  def in_journey?
    @entry_station != nil
  end

  def touch_in(station)
    fail "Your Oystercard has less than £#{MINIMUM}" if limit_reached?
    @entry_station = station
  end

  def touch_out(amount)
    deduct(amount)
  end

  private

  def limit_exceeded?(load)
    load > LIMIT - @balance
  end

  def limit_reached?
    @balance < MINIMUM
  end
end
