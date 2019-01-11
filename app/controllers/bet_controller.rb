class BetController < ApplicationController
  def bet
    p @user

    head :ok
  end
end
