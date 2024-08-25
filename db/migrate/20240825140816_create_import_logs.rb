class CreateImportLogs < ActiveRecord::Migration[7.2]
  def change
    create_table :import_logs do |t|
      t.string :source_file, null: false
      t.boolean :imported, default: false

      t.timestamps
    end
  end
end
