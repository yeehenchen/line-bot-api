class EndService
  def initialize(user, room)
    @room = room
    @user = user
  end

  def end
    return '還沒有開始遊戲ㄛ，用!start開始吧' if Game.where(roomId: @room).select { |g| g.status == false }.blank?

    g = Game.where(roomId: @room).select { |r| r.status == false }.first
    return no_bet(g) if g.bets.blank?

    winbet = g.bets.min_by { |b| (g.winNum - b.num_guess).abs }
    winbet.player.balance += (winbet.amount * g.bets.count)
    winbet.player.save!
    p "Winner : #{winbet.player.displayName}"
    g.winner = winbet.player.displayName
    g.status = true
    g.save!
    "獲勝的是...#{g.displayName}! 答案: #{g.winNum}, #{g.displayName} 賺了 #{winbet.amount * g.bets.count}！"
  end

  def no_bet(g)
    g.winner = nil
    g.status = true
    g.save!
    '沒人要玩ㄇ 哭哭ＱＱ 遊戲結束'
  end
end
