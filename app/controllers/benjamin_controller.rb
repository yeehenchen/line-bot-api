class BenjaminController < ApplicationController
  require 'line/bot'
  # skip the CRSF default check
  protect_from_forgery with: :null_session

  def webhook
    client = Line::Bot::Client.new { |config|
    config.channel_secret = '611968d96a9d492b52867a4397fdbf34'
    config.channel_token = 'noj+ox3Gbxm7a/Sd1RWjKzFrw0qehXGpmNAZlXwY5A2O6Jk/uKUFtdQBL67pNINas8jUuJX/tLDftOt7LB7hpF4wFL7RVviXQdJPmSNcZHgXbO4Xp8CLGFNrGh+Fc9ag2Gg0I1FrDaWYfAo6/bUrJQdB04t89/1O/w1cDnyilFU='
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
