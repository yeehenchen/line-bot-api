class BenjaminController < ApplicationController
  require 'line/bot'
  # skip the CRSF default check
  protect_from_forgery with: :null_session

  def webhook
    client = Line::Bot::Client.new { |config|
      config.channel_secret = ENV["LINE_SECRET"]
      config.channel_token = ENV["LINE_TOKEN"]
    }

    # 取得 reply token
    reply_token = params['events'][0]['replyToken']

    # 設定回覆訊息
    message = {
      type: 'text',
      text: '好哦～好哦～'
    }

    # 傳送訊息
    response = client.reply_message(reply_token, message)

    head :ok
  end
end
