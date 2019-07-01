class Oystercard

  attr_reader :balance

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
    @in_journey = false
  end

  def top_up(load)
    fail "Card limit is #{LIMIT}, your balance is #{@balance}" if limit_exceeded?(load)
    @balance += load
  end

  def deduce(amount)
    @balance -= amount
  end

  def in_journey?
    @in_journey
  end

  def touch_in
    fail "Your Oystercard has less than £#{MINIMUM}" if limit_reached?
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end

  private

  def limit_exceeded?(load)
    load > LIMIT - @balance
  end

  def limit_reached?
    @balance < MINIMUM
  end
end
