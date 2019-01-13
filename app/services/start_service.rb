class StartService
  def initialize(user, room)
    @room = room
    @user = user
  end

  def start
    return 'Already started a game, !end it first to start another one' unless Game.where(roomId: @room).select { |r| r.status == false }.blank?

    Game.create(roomId: @room, winNum: rand(100))
    'Game started!!! See who is closer to the answer.'
  end
end

