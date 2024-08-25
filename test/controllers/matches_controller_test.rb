require "test_helper"
require "mocha/minitest"

class MatchesControllerTest < ActionDispatch::IntegrationTest

  test "should get to the matches page" do
    stubbed_object = [ "object1", "object2" ]
    Match.expects(:all).returns(stubbed_object)

    get matches_path

    assert_response :success

    assert_select "div", "Total of Matches: 2"
    assert_select "a", "Back to logs", "Should have a link with text 'Back to logs'"
  end
end
