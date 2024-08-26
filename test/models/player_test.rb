require "test_helper"

class PlayerTest < ActiveSupport::TestCase
  test "should create new player" do
    new_player = Player.new(name: "John")

    assert new_player.save, "Should have saved the player successfully"
    assert_equal "John", new_player.name, "Player's name should match the given name"
  end
end
