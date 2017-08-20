require 'test_helper'

class ProjectTeamMembersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get project_team_members_new_url
    assert_response :success
  end

  test "should get index" do
    get project_team_members_index_url
    assert_response :success
  end

  test "should get show" do
    get project_team_members_show_url
    assert_response :success
  end

  test "should get edit" do
    get project_team_members_edit_url
    assert_response :success
  end

end
