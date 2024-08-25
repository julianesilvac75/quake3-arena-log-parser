require "test_helper"

class MatchesControllerTest < ActionDispatch::IntegrationTest
  def setup
    get matches_path
  end

  test "should get to the matches page" do
    assert_response :success

    assert_select "div", "Total of Matches: 2", "Should show corret total of matches"
    assert_select "a", "Back to logs", "Should have a link with text 'Back to logs'"
  end
end
