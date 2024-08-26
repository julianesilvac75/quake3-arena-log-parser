class Player < ApplicationRecord
  has_many :matches_players
  has_many :matches, through: :matches_players
end
