require "test_helper"
require "mocha/minitest"

class PlayersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @mocked_objects = [ Player.new(name: "John"), Player.new(name: "Mary")]
  end

  test "should get to the players page" do
    Player.expects(:all).returns(@mocked_objects)

    get players_path

    assert_response :success

    assert_select "h1", "Players"
    assert_select "li", "John"
    assert_select "li", "Mary"
  end
end
