require "test_helper"
require "mocha/minitest"

class LogImporterTest < ActiveSupport::TestCase
  def setup
    @log_file_path = Rails.root.join("test", "fixtures", "files", "qgames.log").to_s
    @new_import = LogImporter.new(@log_file_path)
  end

  test "should return a log file registry if it exists" do
    @stubbed_object = ImportLog.new(source_file: @log_file_path, imported: true)

    ImportLog.expects(:where).returns([ @stubbed_object ])

    result = LogImporter.find_file(@log_file_path)

    assert_equal @stubbed_object, result, "Should return the import log registry"
    assert_kind_of ImportLog, result
  end

  test "should return false if the log file registry doesn't exist" do
    ImportLog.expects(:where).returns([])

    result = LogImporter.find_file("non/existent/log_file.log")

    assert_equal false, result, "Should return false"
  end

  test "should import log only if it wasn't imported yet" do
    assert @new_import.import, "Should import log if it doesn't exist yet"

    result2 = LogImporter.new(@log_file_path)

    assert_not result2.import, "Should not import log if it already exists"
  end
end
