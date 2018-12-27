require 'line/bot'

class ChannelsController < ApplicationController
  # skip the CRSF default check
  protect_from_forgery with: :null_session

  def new

  end

  def create

  end

  def line
    @line ||= Line::Bot::Client.new { |config|
      config.channel_secret = ENV['LINE_SECRET']
      config.channel_token = ENV['LINE_TOKEN']
    }
  end
end
