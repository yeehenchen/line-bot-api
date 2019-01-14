class Bet < ApplicationRecord
  belongs_to :player
  belongs_to :game

  validates :num_guess, presence: true, uniqueness: { scope: :game_id, message: 'error : 數字只能下一次' }, inclusion: { in: (1..100), message: 'error : %{value}不在1到100之間' }
  validates :amount, presence: true
end
