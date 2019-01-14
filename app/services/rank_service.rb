class RankService
  def initialize(user, des, type)
    @des = des
    @user = user
    @type = type
  end

  def rank
    return '你們還沒有開始/完成任何一場遊戲ㄛ，用!start開始吧！' if Game.where(roomId: @des).select { |r| r.status == true }.blank?

    games = Game.where(roomId: @des).select { |r| r.status == true }
    rank = Hash.new(0)
    games.each do |g|
      rank[g.winner] += 1
    end
    p rank
  end
end
# Not available if register
# def get_players_from_des(des)
#   players = Hash.new(0)
#   url = "https://api.line.me/v2/bot/#{@type}/#{des}/members/ids"
#   res = open(url, 'Authorization' => "Bearer #{ENV['LINE_TOKEN']}").read
#   res["memberIds"].each do |m|
#     p = Player.where(userId == m)
#     players[p.displayName] = 0
#   end
#   p players
# end
