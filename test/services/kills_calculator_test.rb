require "test_helper"
require "mocha/minitest"

class KillsCalculatorTest < ActiveSupport::TestCase
  test "should create a new kill calculator instance" do
    match = Match.new
    calculator = KillsCalculator.new(match)
    assert_instance_of KillsCalculator, calculator
  end
end
