class BenjaminController < ApplicationController
  # skip the CRSF default check
  protect_from_forgery with: :null_session

  def webhook
    render plain: "test"
  end
end
