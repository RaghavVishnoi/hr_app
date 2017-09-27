require 'test_helper'

class PerfReviewCatgsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @perf_review_catg = perf_review_catgs(:one)
  end

  test "should get index" do
    get perf_review_catgs_url
    assert_response :success
  end

  test "should get new" do
    get new_perf_review_catg_url
    assert_response :success
  end

  test "should create perf_review_catg" do
    assert_difference('PerfReviewCatg.count') do
      post perf_review_catgs_url, params: { perf_review_catg: { employee_id: @perf_review_catg.employee_id, name: @perf_review_catg.name } }
    end

    assert_redirected_to perf_review_catg_url(PerfReviewCatg.last)
  end

  test "should show perf_review_catg" do
    get perf_review_catg_url(@perf_review_catg)
    assert_response :success
  end

  test "should get edit" do
    get edit_perf_review_catg_url(@perf_review_catg)
    assert_response :success
  end

  test "should update perf_review_catg" do
    patch perf_review_catg_url(@perf_review_catg), params: { perf_review_catg: { employee_id: @perf_review_catg.employee_id, name: @perf_review_catg.name } }
    assert_redirected_to perf_review_catg_url(@perf_review_catg)
  end

  test "should destroy perf_review_catg" do
    assert_difference('PerfReviewCatg.count', -1) do
      delete perf_review_catg_url(@perf_review_catg)
    end

    assert_redirected_to perf_review_catgs_url
  end
end
