require "test_helper"
require "mocha/minitest"

class LogsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @log_parser_mock = mock("LogParser")
    @logs_mock = YAML.load_file(
      Rails.root.join("test", "fixtures", "files", "game_logs_mock.yml")
    )["game_logs"]

    @log_parser_mock.stubs(:parse).returns(@logs_mock)

    LogParser.stubs(:new).returns(@log_parser_mock)

    get logs_parse_url
  end

  test "should get parsed logs" do
    assert_response :success
    # assert_not_nil assigns(:logs), "Did not get logs"
  end
end
