require 'test_helper'

class PerfReviewRequestsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @perf_review_request = perf_review_requests(:one)
  end

  test "should get index" do
    get perf_review_requests_url
    assert_response :success
  end

  test "should get new" do
    get new_perf_review_request_url
    assert_response :success
  end

  test "should create perf_review_request" do
    assert_difference('PerfReviewRequest.count') do
      post perf_review_requests_url, params: { perf_review_request: { avg: @perf_review_request.avg, flag: @perf_review_request.flag, reviewee_id: @perf_review_request.reviewee_id, reviewer_id: @perf_review_request.reviewer_id } }
    end

    assert_redirected_to perf_review_request_url(PerfReviewRequest.last)
  end

  test "should show perf_review_request" do
    get perf_review_request_url(@perf_review_request)
    assert_response :success
  end

  test "should get edit" do
    get edit_perf_review_request_url(@perf_review_request)
    assert_response :success
  end

  test "should update perf_review_request" do
    patch perf_review_request_url(@perf_review_request), params: { perf_review_request: { avg: @perf_review_request.avg, flag: @perf_review_request.flag, reviewee_id: @perf_review_request.reviewee_id, reviewer_id: @perf_review_request.reviewer_id } }
    assert_redirected_to perf_review_request_url(@perf_review_request)
  end

  test "should destroy perf_review_request" do
    assert_difference('PerfReviewRequest.count', -1) do
      delete perf_review_request_url(@perf_review_request)
    end

    assert_redirected_to perf_review_requests_url
  end
end
