require 'test_helper'

class AdminControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get admin_path
    assert_response :success
  end

end
