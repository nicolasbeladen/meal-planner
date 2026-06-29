require "test_helper"

class MenusControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get get menus_url
    assert_response :success
  end
end
