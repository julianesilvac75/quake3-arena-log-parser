require "test_helper"

class MatchTest < ActiveSupport::TestCase
  test "should create a match with valid id" do
    match = Match.new

    assert match.save, "Match should be saved successfully"
    assert match.id.present?, "Match should have an id"
    assert_kind_of Integer, match.id, "Match should have an id that is a number"
  end
end
