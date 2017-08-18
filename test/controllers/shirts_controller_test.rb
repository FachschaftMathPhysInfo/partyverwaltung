require 'test_helper'

class ShirtsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get shirts_index_url
    assert_response :success
  end

end
