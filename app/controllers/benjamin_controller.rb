require 'line/bot'

class BenjaminController < ApplicationController
  # skip the CRSF default check
  protect_from_forgery with: :null_session

  def webhook
    # reply text
    reply_text = keyword_reply(received_text)

    # reply message
    reply_to_line(reply_text)

    head :ok
  end

  def received_text
    params['events'][0]['message']['text'] unless params['events'][0]['message'].nil?
  end

  def keyword_reply(received_text)
    if received_text.nil?
      "別傳貼圖了，快問我迪卡儂的事情！想知道#{Link.find(rand(Link.count)).word}嗎？"
    else
      return "Yeehen是神" unless received_text['yeehen'].nil?

      link = Link.where("word LIKE '%#{received_text}%'").first
      "你是說迪卡儂的#{link.word}嗎？ 快去吧！#{link.link}"
    end
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

    # setup replying message
    message = {
      type: 'text',
      text: reply_text
    }

    # call the reply function
    line.reply_message(reply_token, message)
  end
end
