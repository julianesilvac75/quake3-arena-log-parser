class MatchesPlayer < ApplicationRecord
  belongs_to :match
  belongs_to :player

  validates :assigned_id, presence: true
end
