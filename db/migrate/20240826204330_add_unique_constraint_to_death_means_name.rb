class AddUniqueConstraintToDeathMeansName < ActiveRecord::Migration[7.2]
  def change
    add_index :death_means, :name, unique: true
  end
end
