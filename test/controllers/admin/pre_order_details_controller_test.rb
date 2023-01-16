require "test_helper"

class Admin::PreOrderDetailsControllerTest < ActionDispatch::IntegrationTest
  test "should get update" do
    get admin_pre_order_details_update_url
    assert_response :success
  end
end
