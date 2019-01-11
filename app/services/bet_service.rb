class BetService
  def initialize(user, balance)
    @balance = balance
    @user = user
  end

  def bet
    u.balance -= @balance
    u.save!
  end
end
