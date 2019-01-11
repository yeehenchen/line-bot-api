class Bet < ApplicationRecord
  belongs_to :player
  belongs_to :game

  validates :num_guess, presence: true, inclusion: { in: [1..100],
    message: '%{value} is not a valid size' }
  validates :amount, presence: true
end
