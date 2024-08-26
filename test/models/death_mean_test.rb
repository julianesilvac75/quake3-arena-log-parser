require "test_helper"

class DeathMeanTest < ActiveSupport::TestCase
  test "should create a match with valid id" do
    death_mean = DeathMean.new(name: "Rocket_splash")

    assert death_mean.save
    assert_equal death_mean.name, "Rocket_splash"
    assert_kind_of DeathMean, death_mean
  end
end
