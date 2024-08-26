require "test_helper"

class MatchesPlayerTest < ActiveSupport::TestCase
  def setup
    @match = Match.create!
    @player = Player.create!(name: "Marcus")
    @matches_player = MatchesPlayer.new(match: @match, player: @player, assigned_id: 1, name_used: "John")
  end
  test "should be valid with valid attributes" do
    assert @matches_player.valid?
  end

  test "should require a match" do
    @matches_player.match = nil
    assert_not @matches_player.valid?
  end

    test "should require a player" do
      @matches_player.player = nil
      assert_not @matches_player.valid?
    end

  test "should require an assigned_id" do
    @matches_player.assigned_id = nil
    assert_not @matches_player.valid?
  end

  test "should belong to match and player" do
    assert_equal @match, @matches_player.match
    assert_equal @player, @matches_player.player
  end
end
