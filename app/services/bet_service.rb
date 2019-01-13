class BetService
  def initialize(user, room, params = [])
    @user = user
    @room = room
    @amount = params[0].to_i
    @num_guess = params[1].to_i
  end

  def bet
    # check if game exists
    game = Game.where(roomId: @room).select { |g| g.status == false }.first
    return '還沒有開始遊戲ㄛ，用!start開始吧' if game.blank?

    # create a bet
    bet = Bet.new(amount: @amount, num_guess: @num_guess, game_id: game.id, player_id: @user.id)

    if @user.balance >= @amount
      if bet.save
        @user.balance -= @amount
        @user.save
        game.winNum = (game.winNum * (game.bets.count - 1) + @num_guess) / game.bets.count
        game.save
        "#{@user.displayName}下注成功！"
      else
        bet.errors.full_messages.sum
      end
    else
      "#{@user.displayName}的餘額不足，哭哭喔"
    end
  end
end
