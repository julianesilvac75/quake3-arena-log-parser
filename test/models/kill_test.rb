require "test_helper"

class KillTest < ActiveSupport::TestCase
  def setup
    @match = Match.new
    @killer = Player.new(name: "Oliver")
    @killed = Player.new(name: "Sophia")
    @death_mean = DeathMean.new(name: "Machinegun")
    @kill = Kill.new(match: @match, killer: @killer, killed: @killed, death_mean: @death_mean)
  end

  test "should create a new kill registry" do
    assert @kill.save
  end

  test "should validate presence of match, killer, killed and death mean" do
    assert_equal @match, @kill.match
    assert_equal @killer, @kill.killer
    assert_equal @killed, @kill.killed
    assert_equal @death_mean, @kill.death_mean
  end
end
