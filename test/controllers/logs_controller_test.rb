require "test_helper"
require "mocha/minitest"

class LogsControllerTest < ActionDispatch::IntegrationTest
  def setup
    get logs_path
  end

  test "should get to the home page" do
    assert_response :success

    assert_select "h1", "Quake 3 Arena", "Should have a title"
    assert_select "h2", "Matches Index", "Should have a subtitle"

    assert_select "a", "Matches", "Should have a link to the Matches page"
    assert_select "a", "Players", "Should have a link to the Players page"
    assert_select "a", "Means of Death", "Should have a link to the Dead Means page"
  end
end
