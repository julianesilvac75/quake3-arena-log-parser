class AddUniqueIndexToSourceFileInImportLog < ActiveRecord::Migration[7.2]
  def change
    add_index :import_logs, :source_file, unique: true
  end
end
