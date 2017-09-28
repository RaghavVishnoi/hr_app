require 'test_helper'

class PerfReviewsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @perf_review = perf_reviews(:one)
  end

  test "should get index" do
    get perf_reviews_url
    assert_response :success
  end

  test "should get new" do
    get new_perf_review_url
    assert_response :success
  end

  test "should create perf_review" do
    assert_difference('PerfReview.count') do
      post perf_reviews_url, params: { perf_review: { avg: @perf_review.avg, catg_reviews: @perf_review.catg_reviews, employee_id: @perf_review.employee_id, first_prepared: @perf_review.first_prepared, hiring_date: @perf_review.hiring_date, job_title: @perf_review.job_title, last_appraisal: @perf_review.last_appraisal, name: @perf_review.name, prepared_by: @perf_review.prepared_by, reviewer_id: @perf_review.reviewer_id, team_leader: @perf_review.team_leader, time_in_position: @perf_review.time_in_position } }
    end

    assert_redirected_to perf_review_url(PerfReview.last)
  end

  test "should show perf_review" do
    get perf_review_url(@perf_review)
    assert_response :success
  end

  test "should get edit" do
    get edit_perf_review_url(@perf_review)
    assert_response :success
  end

  test "should update perf_review" do
    patch perf_review_url(@perf_review), params: { perf_review: { avg: @perf_review.avg, catg_reviews: @perf_review.catg_reviews, employee_id: @perf_review.employee_id, first_prepared: @perf_review.first_prepared, hiring_date: @perf_review.hiring_date, job_title: @perf_review.job_title, last_appraisal: @perf_review.last_appraisal, name: @perf_review.name, prepared_by: @perf_review.prepared_by, reviewer_id: @perf_review.reviewer_id, team_leader: @perf_review.team_leader, time_in_position: @perf_review.time_in_position } }
    assert_redirected_to perf_review_url(@perf_review)
  end

  test "should destroy perf_review" do
    assert_difference('PerfReview.count', -1) do
      delete perf_review_url(@perf_review)
    end

    assert_redirected_to perf_reviews_url
  end
end
