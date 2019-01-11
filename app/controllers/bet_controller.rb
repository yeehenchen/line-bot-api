class BetController < ApplicationController
  def bet
    @user.balance -= params[:param]
    @user.save!

    head :ok
  end
end
