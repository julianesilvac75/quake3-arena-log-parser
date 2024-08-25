require "test_helper"

class LogImporterTest < ActiveSupport::TestCase
  def setup
    @log_file_path = Rails.root.join("test", "fixtures", "files", "qgames.log").to_s
  end

  test "should import log only if it wasn't imported yet" do
    result1 = LogImporter.import(@log_file_path)

    assert result1

    result2 = LogImporter.import(@log_file_path)

    assert_not result2
  end
end
