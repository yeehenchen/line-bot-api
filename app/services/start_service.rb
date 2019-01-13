class StartService
  def initialize(user, room)
    @room = room
    @user = user
  end

  def start
    return 'Already started a game, !end it first to start another one' unless Game.where(roomId: @room).select { |g| g.status == false }.blank?

    Game.create(roomId: @room, winNum: rand(100))
    'Game started!!! Guess a number between 1 - 100 to win the bet pool.'
  end
end
