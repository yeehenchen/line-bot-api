class RankService
  def initialize(user, room)
    @room = room
    @user = user
  end

  def end
    return '你們還沒有開始/完成任何一場遊戲ㄛ，用!start開始吧！' if Game.where(roomId: @room).select { |r| r.status == true }.blank?

    games = Game.where(roomId: @room).select { |r| r.status == true }
    players = get_players_in_room(@room)
  end

  def get_players_in_room(room)


  end
end
