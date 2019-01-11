class BetService
  def initialize(user, balance)
    @balance = balance
    @user = user
  end

  def bet
    @user.balance -= @balance
    @user.save!
  end
end
