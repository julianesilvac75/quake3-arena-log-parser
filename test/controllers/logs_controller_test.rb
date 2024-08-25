require "test_helper"
require "mocha/minitest"

class LogsControllerTest < ActionDispatch::IntegrationTest
  def setup
    get logs_path
  end

  test "should get to the home page" do
    assert_response :success

    assert_select "h1", "Logs#Index", "Should have a title"

    assert_select "a", "Matches", "Should have a link to the Matches page"
  end
end
