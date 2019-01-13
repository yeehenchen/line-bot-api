class BalanceService
  def initialize(user)
    @user = user
  end

  def balance
    "#{@user.displayName} : 餘額#{@user.balance}元"
  end
end
