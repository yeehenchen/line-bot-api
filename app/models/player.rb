class Player < ApplicationRecord
  has_many :bets
  has_many :games, through: :bets

  attribute :balance, :integer, default: 1000

  validates :userId, uniqueness: { scope: :displayName }, presence: true
end
