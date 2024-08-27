require "test_helper"

class MatchesControllerTest < ActionDispatch::IntegrationTest
  fixtures :matches_players, :players, :matches
  def setup
    get matches_path
  end
  test "should get to the matches page" do
    assert_response :success

    assert_select "h2", "Total of Matches: 2"
    assert_select "a", "Back to Home", "Should have a link with text 'Back to logs'"
  end

  test "should display Matches links" do
    assert_select "h3", "Match 1"
    assert_select "h3", "Match 2"
  end
end
