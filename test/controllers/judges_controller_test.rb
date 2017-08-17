require 'test_helper'

class JudgesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get judges_index_url
    assert_response :success
  end

end
