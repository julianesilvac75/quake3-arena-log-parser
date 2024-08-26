class Match < ApplicationRecord
  has_many :matches_players
  has_many :players, through: :matches_players
  has_many :kills
end
