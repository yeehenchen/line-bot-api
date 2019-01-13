require 'line/bot'
require 'open-uri'
require 'json'

class BenjaminController < ApplicationController
  # skip the CRSF default check
  protect_from_forgery with: :null_session

  def webhook
    case command_identify(received_text)
    when nil
      # reply text
      reply_text = keyword_reply(received_text)

      # reply message
      text_to_line(reply_text)
    when String
      userid = params['events'][0]['source']['userId']
      p user_profile(userid)
      @user = user_profile(userid) ? Player.find_or_create_by(user_profile(userid)) : nil
      return text_to_line('加好友才能使用功能哦！快加ㄅ') unless @user

      des = params['events'][0]['source']['roomId'] || params['events'][0]['source']['groupId']
      return text_to_line('You cannot play alone, LOSER! Go find some friends la.') if des.nil?

      case command_identify(received_text)
      when '!bet'
        s = BetService.new(@user, des, command_params(received_text))
        text_to_line(s.bet)
      when '!start'
        s = StartService.new(@user, des)
        text_to_line(s.start)
      when '!end'
        s = EndService.new(@user, des)
        text_to_line(s.end)
      when '!balance'
        s = BalanceService.new(@user)
        text_to_line(s.balance)
      when '!rank'
        s = RankService.new(@user, des)
        s.sth
      when '!rule'
        text_to_line('
          這是一個充滿心機的遊戲！每位玩家每次可以花錢賭一個數字，同一個數字無法下注兩次，最終答案是所有數字的平均值，最接近這位數字的玩家會獲得該注賭金Ｘ總下注次數的獎金！若結果相同則以先下注的玩家為贏家！
          ')
      when '!help'
        text_to_line('
          Type !start to start a game \n
          !end to end a game & get the winner \n
          !bet to place a bet (betting format !bet amount number e.q. !bet 1000 35) \n
          !balance to know how much money in your account \n
          !rule to know the game rule
          ')
      end
    end
    head :ok
  end

  def user_profile(userid)
    url = "https://api.line.me/v2/bot/profile/#{userid}"
    begin
      profile = open(url, 'Authorization' => "Bearer #{ENV['LINE_TOKEN']}").read
    rescue
      return nil
    end
    profile = JSON.parse(profile)
    profile.delete(:statusMessage) if profile[:statusMessage]
    profile
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
