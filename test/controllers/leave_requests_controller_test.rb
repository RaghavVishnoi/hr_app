require 'test_helper'

class LeaveRequestsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get leave_requests_index_url
    assert_response :success
  end

end
