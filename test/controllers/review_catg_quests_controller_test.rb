require 'test_helper'

class ReviewCatgQuestsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @review_catg_quest = review_catg_quests(:one)
  end

  test "should get index" do
    get review_catg_quests_url
    assert_response :success
  end

  test "should get new" do
    get new_review_catg_quest_url
    assert_response :success
  end

  test "should create review_catg_quest" do
    assert_difference('ReviewCatgQuest.count') do
      post review_catg_quests_url, params: { review_catg_quest: { category_id: @review_catg_quest.category_id, name: @review_catg_quest.name } }
    end

    assert_redirected_to review_catg_quest_url(ReviewCatgQuest.last)
  end

  test "should show review_catg_quest" do
    get review_catg_quest_url(@review_catg_quest)
    assert_response :success
  end

  test "should get edit" do
    get edit_review_catg_quest_url(@review_catg_quest)
    assert_response :success
  end

  test "should update review_catg_quest" do
    patch review_catg_quest_url(@review_catg_quest), params: { review_catg_quest: { category_id: @review_catg_quest.category_id, name: @review_catg_quest.name } }
    assert_redirected_to review_catg_quest_url(@review_catg_quest)
  end

  test "should destroy review_catg_quest" do
    assert_difference('ReviewCatgQuest.count', -1) do
      delete review_catg_quest_url(@review_catg_quest)
    end

    assert_redirected_to review_catg_quests_url
  end
end
