require "test_helper"
require "mocha/minitest"

class KillHandlerTest < ActiveSupport::TestCase
  def setup
    @line_with_killer = "22:06 Kill: 2 3 7: John killed Mary by MOD_ROCKET_SPLASH"
    @match = Match.new
    @killer = players(:three)
    @killed = players(:two)
    @death_mean = DeathMean.new(name: "MOD_ROCKET_SPLASH")

    @kill_handler = KillHandler.new(@line_with_killer, 5)
  end

  test "should get killer and killer names and death mean correctly" do
    @kill_handler.get_kill_info

    assert_equal @killer.name, @kill_handler.instance_variable_get(:@killer)
    assert_equal @killed.name, @kill_handler.instance_variable_get(:@killed)
    assert_equal @death_mean.name, @kill_handler.instance_variable_get(:@death_mean)
  end

  test "should get nil value when killer is <world>" do
    @line_with_world = "22:06 Kill: 2 3 7: <world> killed Mary by MOD_ROCKET_SPLASH"
    @kill_handler = KillHandler.new(@line_with_world, 5)
    @kill_handler.get_kill_info

    assert_nil @kill_handler.instance_variable_get(:@killer)
  end

  test "should return the killer object if the killer name is valid" do
    @kill_handler.instance_variable_set(:@killer, "John")

    killer_player = @kill_handler.get_killer_player

    assert_equal @killer, killer_player
    assert_kind_of Player, @kill_handler.instance_variable_get(:@killer)
    assert_equal @killer, @kill_handler.instance_variable_get(:@killer)
  end

  test "should return nil if the killer name is not valid" do
    killer_player = @kill_handler.get_killer_player

    assert_nil killer_player
    assert_nil @kill_handler.instance_variable_get(:@killer)
  end

  test "should return the killed object if the killed name is valid" do
    killed_player = @kill_handler.instance_variable_set(:@killed, @killed)

    assert_equal @killed, killed_player
    assert_kind_of Player, @kill_handler.instance_variable_get(:@killed)
    assert_equal @killed, @kill_handler.instance_variable_get(:@killed)
  end

  test "should return death mean object if it exists" do
    DeathMean.expects(:find_by_name).returns(@death_mean)

    death_mean = @kill_handler.get_death_mean

    assert_kind_of DeathMean, death_mean
    assert_equal @death_mean, death_mean
    assert_equal @death_mean, @kill_handler.instance_variable_get(:@death_mean)
  end

  test "should create a new death_mean object if it does not exist" do
    new_death_mean = DeathMean.new(name: "Machinegun", description: "by a machinegun")
    @kill_handler.instance_variable_set(:@death_mean, "Machinegun")

    DeathMean.expects(:create).returns(new_death_mean)

    death_mean = @kill_handler.get_death_mean

    assert_kind_of DeathMean, death_mean
    assert_equal death_mean, new_death_mean
    assert_equal death_mean, @kill_handler.instance_variable_get(:@death_mean)
  end

  test "should create a new kill object with the given information" do
    stubbed_kill = Kill.new(match: @match, killer: @killer, killed: @killed, death_mean: @death_mean)

    Kill.expects(:create).returns(stubbed_kill)

    kill = @kill_handler.handle

    assert_kind_of Kill, kill
    assert_equal kill.match, @match
    assert_equal kill.killer, @killer
    assert_equal kill.killed, @killed
    assert_equal kill.death_mean, @death_mean
  end

  test "should return correct death mean description" do
    @kill_handler.instance_variable_set(:@death_mean, "MOD_TRIGGER_HURT")

    description = @kill_handler.get_death_mean_description

    assert_equal "by some environment danger.", description
  end
end
