class CreateMatchesPlayers < ActiveRecord::Migration[7.2]
  def change
    create_table :matches_players do |t|
      t.references :match, null: false, foreign_key: true
      t.references :player, null: false, foreign_key: true
      t.integer :assigned_id

      t.timestamps
    end
  end
end
