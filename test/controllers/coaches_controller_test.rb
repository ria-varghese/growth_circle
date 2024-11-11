require "test_helper"

class CoachesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get coaches_new_url
    assert_response :success
  end

  test "should get create" do
    get coaches_create_url
    assert_response :success
  end
end
