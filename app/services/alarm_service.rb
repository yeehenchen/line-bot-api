require 'line/bot'

class AlarmService
  def client
    @client ||= Line::Bot::Client.new do |config|
      config.channel_secret = ENV['LINE_SECRET']
      config.channel_token = ENV['LINE_TOKEN']
    end
  end

  def run
    message = {
      type: 'text',
      text: '這禮拜六來抱石或是打羽毛球啊 https://xzcsc.cyc.org.tw/'
    }
    client.push_message('Rb25fb30eb5ec4a7921216ed21ebc0ee4', message)
  end
end
