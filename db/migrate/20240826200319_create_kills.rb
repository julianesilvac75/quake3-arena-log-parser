class CreateKills < ActiveRecord::Migration[7.2]
  def change
    create_table :kills do |t|
      t.references :match, null: false, foreign_key: { to_table: :matches }
      t.references :killer, null: false, foreign_key: { to_table: :players }
      t.references :killed, null: false, foreign_key: { to_table: :players }
      t.references :death_mean, null: false, foreign_key: { to_table: :death_means }

      t.timestamps
    end
  end
end
