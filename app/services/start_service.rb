class StartService
  def initialize(user, room)
    @room = room
    @user = user
  end

  def start
    return 'Already started a game, !end it first to start another one' if Game.where('roomId = ?', @room).each { |r| r.status = false }

    Game.create(roomId: @room, winNum: rand(100))
    'Game started!!! See who is closer to the answer.'
  end
end
