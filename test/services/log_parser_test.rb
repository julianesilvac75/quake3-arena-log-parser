require "test_helper"

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

  test "shoud create a new Match object when the log is valid" do
    @parsed_logs.each do |log|
      if log.include?("InitGame:")
        new_match = @log_parser.create_match

        assert new_match.is_a?(Match), "Match object should be created"
        assert new_match.id.present?, "Match object should have an id"
      end
    end
  end

  test "should update current_match when a new match starts" do
    @parsed_logs.each do |log|
      if log.include?("InitGame:")
        new_match = @log_parser.create_match

        assert @log_parser.current_match.present?, "Current match value must be present"
        assert_equal new_match.id, @log_parser.current_match, "Current match value must match new match id"
      end
    end
  end

  test "shoud create a new player when the log is valid" do
    @parsed_logs.each do |log|
      if log.include?("ClientUserinfoChanged:")
        name_match = log.match(/n\\([^\\]+)\\t/)
        # match_data = log.match(/ClientUserinfoChanged:\s(\d+)\sn([^\t\\]+)/)
        new_player = @log_parser.create_player(log)

        assert new_player.is_a?(Player)
        assert_equal new_player.name, name_match[1], "Match object should have an id"
      end
    end
  end
end
