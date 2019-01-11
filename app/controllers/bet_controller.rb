class BetController < ApplicationController
  def bet
    p "1 st #{params}"
    p "2 nd #{params[:params]}"

    head :ok
  end
end
