require 'line/bot'

class BenjaminController < ApplicationController
  # skip the CRSF default check
  protect_from_forgery with: :null_session

  def webhook
    # reply text
    reply_text = '好哦～好哦～'

    # reply message
    reply_to_line(reply_text)

    head :ok
  end

  def line
    @line ||= Line::Bot::Client.new { |config|
      config.channel_secret = ENV['LINE_SECRET']
      config.channel_token = ENV['LINE_TOKEN']
    }
  end

  def reply_to_line(reply_text)
    # get reply token
    reply_token = params['events'][0]['replyToken']

    message = {
      type: 'text',
      text: reply_text
    }
    p message
    line.reply_message(reply_token, message)
  end
end
