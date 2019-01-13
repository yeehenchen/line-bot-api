class Bet < ApplicationRecord
  belongs_to :player
  belongs_to :game

  validates :num_guess, presence: true, uniqueness: { scope: :player_id, message: 'one number per player' }, inclusion: { in: (1..100), message: '%{value} is not a valid number' }
  validates :amount, presence: true
end
