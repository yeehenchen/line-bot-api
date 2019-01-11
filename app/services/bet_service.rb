class BetService
  def initialize(user, room, params = [])
    @user = user
    @room = room
    @balance = params[0].to_i
    @amount = params[1].to_i
    @num_guess = params[2].to_i
  end

  def bets
    if Game.where(roomId == @room).select { |g| g.status == false }
    Bet.new(amount: @amount, num_guess: @num_guess, )
    if @user.balance >= @balance && b.valid?

      @user.balance -= @balance
      @user.save!
    end
  end
end
