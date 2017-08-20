require 'test_helper'

class ProjectTeamsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get project_teams_new_url
    assert_response :success
  end

  test "should get edit" do
    get project_teams_edit_url
    assert_response :success
  end

  test "should get index" do
    get project_teams_index_url
    assert_response :success
  end

  test "should get show" do
    get project_teams_show_url
    assert_response :success
  end

end
