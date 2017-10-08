require 'test_helper'

class LeaveResponsesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @leave_response = leave_responses(:one)
  end

  test "should get index" do
    get leave_responses_url
    assert_response :success
  end

  test "should get new" do
    get new_leave_response_url
    assert_response :success
  end

  test "should create leave_response" do
    assert_difference('LeaveResponse.count') do
      post leave_responses_url, params: { leave_response: {  } }
    end

    assert_redirected_to leave_response_url(LeaveResponse.last)
  end

  test "should show leave_response" do
    get leave_response_url(@leave_response)
    assert_response :success
  end

  test "should get edit" do
    get edit_leave_response_url(@leave_response)
    assert_response :success
  end

  test "should update leave_response" do
    patch leave_response_url(@leave_response), params: { leave_response: {  } }
    assert_redirected_to leave_response_url(@leave_response)
  end

  test "should destroy leave_response" do
    assert_difference('LeaveResponse.count', -1) do
      delete leave_response_url(@leave_response)
    end

    assert_redirected_to leave_responses_url
  end
end
