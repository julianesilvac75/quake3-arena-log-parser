require "test_helper"
require "mocha/minitest"

class MatchesControllerTest < ActionDispatch::IntegrationTest
  fixtures :matches_players, :players, :matches
  def setup
    get matches_path
  end
  test "should get to the matches page" do
    assert_response :success

    assert_select "p", "Total of Matches: 2"
    assert_select "a", "Back to logs", "Should have a link with text 'Back to logs'"
  end

  test "should display matchs details" do
    assert_select "h2", "Match 1"
    assert_select "li", "John"

    assert_select "h2", "Match 2"
    assert_select "li", "Mary"
  end
end
