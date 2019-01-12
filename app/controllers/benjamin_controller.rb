require 'line/bot'
require 'open-uri'
require 'json'

class BenjaminController < ApplicationController
  # skip the CRSF default check
  protect_from_forgery with: :null_session

  def webhook
    @user = Player.find_or_create_by(user_profile(params['events'][0]['source']['userId']))
    case command_identify(received_text)
    when nil
      # reply text
      reply_text = keyword_reply(received_text)

      # reply message
      text_to_line(reply_text)
    when String
      # do sth
      room = params['events'][0]['source']['roomId']
      case command_identify(received_text)
      when '!bet'
        s = BetService.new(@user, room, command_params(received_text))
        s.bet
      when '!start'
        return text_to_line('You cannot play alone, LOSER! Go find some friends la.') if room.nil?

        s = StartService.new(@user, room)
        s.sth
      when '!end'
        s = EndService.new(@user, room, command_params(received_text))
        s.sth
      when '!balance'
        s = BalanceService.new(@user, command_params(received_text))
        s.sth
      when '!rank'
        s = RankService.new(@user, room, command_params(received_text))
        s.sth
      end
    end
    head :ok
  end

  def user_profile(userid)
    url = "https://api.line.me/v2/bot/profile/#{userid}"
    profile = open(url, 'Authorization' => "Bearer #{ENV['LINE_TOKEN']}").read
    p profile[:statusMessage]
    profile.delete(:statusMessage) if profile[:statusMessage]
    JSON.parse(profile)
  end

  def received_text
    params['events'][0]['message']['text'] unless params['events'][0]['message'].nil?
  end

  def command_identify(received_text)
    received_text[0] == '!' ? received_text.split(' ')[0] : nil
  end

  def command_params(received_text)
    received_text.split(' ').drop(1)
  end

  def keyword_reply(received_text)
    return 'Yeehen是神' unless received_text['Yeehen'].nil?

    return 'Owen桌球比Benson強' unless received_text['Owen'].nil?

    if Link.where("word LIKE '%#{received_text}%'").first
      reply = Link.where("word LIKE '%#{received_text}%'").first
      "你是說迪卡儂的#{reply.word}嗎？ 快去吧！#{reply.link}"
    elsif received_text.length < 4
      received_text
    end
  end

  def line
    @line ||= Line::Bot::Client.new { |config|
      p "config #{config}"
      config.channel_secret = ENV['LINE_SECRET']
      config.channel_token = ENV['LINE_TOKEN']
    }
  end

  def text_to_line(reply_text)
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
