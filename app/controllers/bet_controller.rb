class BetController < ApplicationController
  def bet
    @player = Player.find(params[:user])
    @player.balance -= params[:param].to_i
    @player.save!
    p @player
  end
end
