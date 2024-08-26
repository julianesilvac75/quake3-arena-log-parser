class Kill < ApplicationRecord
  belongs_to :match, class_name: "Match"
  belongs_to :killer, class_name: "Player", optional: true
  belongs_to :killed, class_name: "Player"
  belongs_to :death_mean, class_name: "DeathMean"
end
