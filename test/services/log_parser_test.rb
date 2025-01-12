require "test_helper"
require "mocha/minitest"

class LogParserTest < ActiveSupport::TestCase
  def setup
    @log_file_path = Rails.root.join("test", "fixtures", "files", "qgames.log")
    @log_parser = LogParser.new(@log_file_path)
    @parsed_logs = @log_parser.parse
  end

  test "should parse logs and return array of logs" do
    assert_kind_of Array, @parsed_logs, "Log Parser should object as Array"
    assert_equal 45, @parsed_logs.size, "Log Parser should have a number of logs"
  end

  test "should return only useful logs" do
    logs_categories = [ "InitGame:", "ClientUserinfoChanged:", "Kill:" ]

    @parsed_logs.each do |log|
      assert log.is_a?(String), "Each log should be a string"
      assert logs_categories.any? { |word| log.include?(word) }, "Each log should contain at least one of the useful log categories"
    end
  end

  test "shoud create a new player when the log is valid" do
    @parsed_logs.each do |log|
      if log.include?("ClientUserinfoChanged:")
        new_player = @log_parser.handle_player(log)
        name_match = log.match(/n\\([^\\]+)\\t/)

        assert new_player.is_a?(Player)
        assert_equal new_player.name, name_match[1], "Match object should have an id"
      end
    end
  end

  test "should filter log data correctly" do
    logs = @log_parser.filter_logs
    assert_equal @parsed_logs, logs
  end
end
