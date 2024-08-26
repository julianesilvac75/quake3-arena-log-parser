class Player < ApplicationRecord
  has_many :matches_players
  has_many :matches, through: :matches_players

  validates :name, presence: true, uniqueness: true

  def update_name(new_name)
    if Player.exists?(name: new_name)
      errors.add(:name, "New name is already in use")
      false
    else
      update(name: new_name)
    end

    rescue ActiveRecord::RecordNotUnique
      errors.add(:name, "Name wasn't updated because of a uniqueness constraint")
      false
  end
end
