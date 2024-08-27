class AddDescriptionToDeathMeans < ActiveRecord::Migration[7.2]
  def change
    add_column :death_means, :description, :string
  end
end
