class RankService
  def initialize(user, room)
    @room = room
    @user = user
  end

  def end
    return 'You haven\'t played/finished any game, !start a game first!' if Game.where(roomId: @room).select { |r| r.status == true }.blank?

    games = Game.where(roomId: @room).select { |r| r.status == true }
    players = get_players_in_room(@room)

    games.each do |g| {
      g.winner
    }
  end

  def get_players_in_room(room)


  end
end
