class Game < ApplicationRecord
  has_many :bets

  attribute :winNum, :integer, default: rand(100)
  attribute :status, :boolean, default: false

  validates :roomId, presence: true
end
