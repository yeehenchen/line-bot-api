class BetController < ApplicationController
  def bet
    p "1 st #{params}"
    p "2 nd #{params[:param]}"

    head :ok

    return params
  end
end
