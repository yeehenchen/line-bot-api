class BetService
  def initialize(user, balance)
    @balance = balance[0]
    @user = user
  end

  def bet
    @user.balance -= @balance.to_i
    @user.save!
  end
end
