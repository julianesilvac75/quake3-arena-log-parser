require "test_helper"
require "mocha/minitest"

class LogImporterTest < ActiveSupport::TestCase
  def setup
    @log_file_path = Rails.root.join("test", "fixtures", "files", "qgames.log")
    @new_import = LogImporter.new(@log_file_path)
  end

  test "should return a log file registry if it exists" do
    @stubbed_object = ImportLog.new(source_file: @log_file_path)

    ImportLog.expects(:where).returns([ @stubbed_object ])

    result = @new_import.find_file

    assert_equal @stubbed_object, result, "Should return the import log registry"
    assert_kind_of ImportLog, result
  end

  test "should return false if the log file registry doesn't exists" do
    new_import2 = LogImporter.new(source_file: "non/existent/log_file.log")
    ImportLog.expects(:where).returns([])

    result = new_import2.find_file

    assert_equal false, result, "Should return false"
  end

  test "should not import log if it already exists" do
    @stubbed_object = ImportLog.new(source_file: @log_file_path)

    ImportLog.expects(:where).returns([ @stubbed_object ])

    assert_no_difference "ImportLog.count" do
      @new_import.import
    end
  end

  test "should import log if it doesn't exists" do
    @stubbed_object = ImportLog.new(source_file: @log_file_path)

    ImportLog.expects(:where).returns([])
    ImportLog.expects(:create).returns(@stubbed_object)

    assert_difference "ImportLog.count", 1 do
      @new_import.import
    end
  end
end
