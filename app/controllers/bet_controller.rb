class BetController < ApplicationController
  def bet
    @user = params[:user]
    @user.balance -= params[:param]
    @user.save!

    head :ok
  end
end
