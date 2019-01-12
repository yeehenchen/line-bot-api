class BalanceService
  def initialize(user)
    @user = user
  end

  def balance
    "#{@user.displayName} : #{@user.balance}元"
  end
end
