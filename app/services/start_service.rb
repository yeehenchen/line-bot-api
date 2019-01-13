class StartService
  def initialize(user, room)
    @room = room
    @user = user
  end

  def start
    return '遊戲早就開始惹，快下注！' unless Game.where(roomId: @room).select { |g| g.status == false }.blank?

    Game.create(roomId: @room, winNum: rand(100))
    '遊戲開始！快下注！'
  end
end
