require "test_helper"

class ErrorsControllerTest < ActionDispatch::IntegrationTest
  test "should get correct responde status and error message" do
    get not_found_path

    assert_response :not_found
    assert_select "h1", "Page not found :("
  end
end
