class BetService
  def initialize(user, room, params = [])
    @user = user
    @room = room
    @amount = params[0].to_i
    @num_guess = params[1].to_i
  end

  def bets
    # check if game exists
    game = Game.where(roomId == @room).select { |g| g.status == false }
    # create a bet
    bet = Bet.new(amount: @amount, num_guess: @num_guess, game_id: game.id, player_id: @user.id)
    # check if balance is enough -> return err1
    # then check if bet is valid -> return active record err message
    if @user.balance >= @amount
      # if all good then recalc the balance and place bet
      @user.balance -= @amount
      @user.save!
    end
  end
end
