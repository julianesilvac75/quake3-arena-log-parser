require "test_helper"

class ImportLogTest < ActiveSupport::TestCase
  test "should create a new import registry with imported value being true" do
    @log_file_path = Rails.root.join("test", "fixtures", "files", "qgames.log").to_s
    new_import = ImportLog.new(source_file: @log_file_path, imported: true)

    assert new_import.save, "New import should be saved successfully"
    assert new_import.is_a?(ImportLog), "New import should be an object of ImportLog class"
    assert_equal new_import.source_file, @log_file_path, "New import should have the right source file path"
    assert_equal new_import.imported, true, "New imported should have 'imported' attribute 'true'"
  end
end
