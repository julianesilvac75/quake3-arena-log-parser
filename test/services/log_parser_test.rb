require "test_helper"

class LogParserTest < ActiveSupport::TestCase
  def setup
    @log_file_path = Rails.root.join("test", "fixtures", "files", "qgames.log")
    @log_parser = LogParser.new
  end

  test "should parse logs and return array of logs" do
    logs = @log_parser.parse
    assert_kind_of Array, logs, "Log Parser didn't return an array of logs"
    assert_equal 57, logs.size, "Log size didn't match"
  end
end
