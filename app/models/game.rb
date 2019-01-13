class Game < ApplicationRecord
  has_many :bets

  attribute :winNum, :integer
  attribute :status, :boolean, default: false

  validates :roomId, presence: true
end
