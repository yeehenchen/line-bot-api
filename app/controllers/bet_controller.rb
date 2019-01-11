class BetController < ApplicationController
  def bet
    @user = Player.find(params[:user])
    @user.balance -= params[:param]
    @user.save!

    head :ok
  end
end
