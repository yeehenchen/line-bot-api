require 'line/bot'

class AlarmService
  def client
    @client ||= Line::Bot::Client.new do |config|
      config.channel_secret = ENV['LINE_SECRET2']
      config.channel_token = ENV['LINE_TOKEN2']
    end
  end

  def run
    message = {
      type: 'text',
      text: "現在時間：#{Time.current} 趕快起床吧!"
    }
    client.push_message('Uad5ce4aff89092de5252fd2857fc23c2', message)
  end
end
