class Kill < ApplicationRecord
  has_many :matches, class_name: "Match"

  has_many :death_means, class_name: "DeathMean"
  belongs_to :match, class_name: "Match"
  belongs_to :killer, class_name: "Player", optional: true
  belongs_to :killed, class_name: "Player"
  belongs_to :death_mean, class_name: "DeathMean"
end
