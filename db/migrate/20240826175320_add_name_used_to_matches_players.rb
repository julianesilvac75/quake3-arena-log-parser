class AddNameUsedToMatchesPlayers < ActiveRecord::Migration[7.2]
  def change
    add_column :matches_players, :name_used, :string
  end
end
