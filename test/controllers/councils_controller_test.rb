require 'test_helper'

class CouncilsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get councils_index_url
    assert_response :success
  end

end
