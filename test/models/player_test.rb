require "test_helper"

class PlayerTest < ActiveSupport::TestCase
  test "should create new player" do
    new_player = Player.new(name: "Donald")

    assert new_player.save, "Should have saved the player successfully"
    assert_equal "Donald", new_player.name, "Player's name should match the given name"
  end
end
