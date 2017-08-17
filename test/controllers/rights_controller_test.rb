require 'test_helper'

class RightsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get rights_index_url
    assert_response :success
  end

end
