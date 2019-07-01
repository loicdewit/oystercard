class Oystercard

  attr_reader :balance

  LIMIT = 90

  def limit
    LIMIT
  end

  def initialize
    @balance = 0
  end

  def top_up(load)
    fail "Card limit is #{LIMIT}, your balance is #{@balance}" if limit_exceeded?(load)
    @balance += load
  end

  def deduce(amount)
    @balance -= amount
  end

  private

  def limit_exceeded?(load)
    load > LIMIT - @balance
  end
end
