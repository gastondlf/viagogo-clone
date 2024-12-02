require "test_helper"

class OrdersControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get orders_create_url
    assert_response :success
  end

  test "should get my_orders" do
    get orders_my_orders_url
    assert_response :success
  end
end
