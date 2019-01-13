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
    return 'You haven\'t created a game, !start a game first!' if game.blank?

    # create a bet
    bet = Bet.new(amount: @amount, num_guess: @num_guess, game_id: game.id, player_id: @user.id)

    if @user.balance >= @amount
      if bet.save!
        @user.balance -= @amount
        "Successfully placed bet for #{user.displayName}, good luck!"
      else
        bet.errors.full_messages.sum
      end
    else
      "#{user.displayName}'s balance is not enough"
    end
  end
end
