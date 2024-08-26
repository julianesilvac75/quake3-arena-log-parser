class Kill < ApplicationRecord
  belongs_to :match_id
  belongs_to :killer_id
  belongs_to :killed_id
  belongs_to :death_mean
end
