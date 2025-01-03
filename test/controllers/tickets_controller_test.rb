require "test_helper"

class TicketsControllerTest < ActionDispatch::IntegrationTest
  test "should get update" do
    get tickets_update_url
    assert_response :success
  end

  test "should get destroy" do
    get tickets_destroy_url
    assert_response :success
  end

  test "should get create" do
    get tickets_create_url
    assert_response :success
  end
end
