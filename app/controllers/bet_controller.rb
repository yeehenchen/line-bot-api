class BetController < ApplicationController
  def bet
    @user = Player.find(params[:user])
    @user.balance -= params[:param].to_i
    @user.save!

    head :ok
  end
end
