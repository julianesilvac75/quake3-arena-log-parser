require "test_helper"

class LogParserTest < ActiveSupport::TestCase
  def setup
    @log_file_path = Rails.root.join("test", "fixtures", "files", "qgames.log")
    @log_parser = LogParser.new(@log_file_path)
  end

  test "should parse logs and return array of logs" do
    parsed_logs = @log_parser.parse
    assert_kind_of Array, parsed_logs, "Log Parser should object as Array"
    assert_equal 45, parsed_logs.size, "Log Parser should have a number of logs"
  end

  test "should return only useful logs" do
    @logs_categories = [ "InitGame:", "ClientUserinfoChanged:", "Kill:" ]
    parsed_logs = @log_parser.parse

    parsed_logs.each do |log|
      assert log.is_a?(String), "Each log should be a string"
      assert @logs_categories.any? { |word| log.include?(word) }, "Each log should contain at least one of the useful log categories"
    end
  end

  test "shoud create a new Match object when the log is valid" do
    parsed_logs = @log_parser.parse

    parsed_logs.each do |log|
      if log.include?("InitGame:")
        new_match = Match.create

        assert new_match.is_a?(Match), "Match object should be created"
        assert new_match.id.present?, "Match object should have an id"
      end
    end
  end
end
