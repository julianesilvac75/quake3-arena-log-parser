require "test_helper"

class DeathMeansControllerTest < ActionDispatch::IntegrationTest
  def setup
    get death_means_path
  end

  test "should get to the Means of Death page" do
    assert_response :success
    assert_select "h1", "Means of Death"
  end

  test "should show the Means of Death codes" do
    assert_select "li", "Rocket"
    assert_select "li", "Falling"
  end
end
