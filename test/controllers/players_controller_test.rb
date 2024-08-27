require "test_helper"
require "mocha/minitest"

class PlayersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @stubbed_objects = [ Player.new(name: "John"), Player.new(name: "Mary") ]

    Player.expects(:all).returns(@stubbed_objects)

    get players_path
  end

  test "should get to the players page" do

    assert_response :success

    assert_select "h1", "Players"
    assert_select "li", "John"
    assert_select "li", "Mary"
  end
end
