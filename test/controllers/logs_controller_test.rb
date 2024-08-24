require "test_helper"
require "mocha/minitest"

class LogsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @log_file_path = Rails.root.join("test", "fixtures", "files", "qgames.log")
    @log_parser = LogParser.new(@log_file_path)
    log_parser_mock = mock("LogParser")
    log_parser_mock.stubs(:parse).returns(@log_parser.parse)

    LogParser.stubs(:new).returns(@log_parser_mock)

    get logs_parse_url
  end

  test "should get parsed logs" do
    assert_response :success
    assert_not_nil assigns(:logs)
  end
end
