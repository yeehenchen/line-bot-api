class EndService
  def initialize(user, room)
    @room = room
    @user = user
  end

  def end
    return 'You haven\'t created a game, !start a game first!' if Game.where(roomId: @room).select { |g| g.status == false }.blank?

    g = Game.where(roomId: @room).select { |r| r.status == false }.first
    return 'No one wants to play ?? Crycry' if g.bets.blank?

    winbet = g.bets.min_by { |b| (g.winNum - b.num_guess).abs }
    winbet.player.balance += g.bets.sum(:amount)
    winbet.player.save!
    g.winner = winbet.player
    g.status = true
    g.save!
    "Winner is #{winbet.player.displayName}, answer : #{g.winNum}, #{winbet.player.displayName} earns #{g.bets.sum(:amount)}"
  end
end
