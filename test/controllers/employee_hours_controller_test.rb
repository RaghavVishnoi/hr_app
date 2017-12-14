require 'test_helper'

class EmployeeHoursControllerTest < ActionDispatch::IntegrationTest
  setup do
    @employee_hour = employee_hours(:one)
  end

  test "should get index" do
    get employee_hours_url
    assert_response :success
  end

  test "should get new" do
    get new_employee_hour_url
    assert_response :success
  end

  test "should create employee_hour" do
    assert_difference('EmployeeHour.count') do
      post employee_hours_url, params: { employee_hour: {  } }
    end

    assert_redirected_to employee_hour_url(EmployeeHour.last)
  end

  test "should show employee_hour" do
    get employee_hour_url(@employee_hour)
    assert_response :success
  end

  test "should get edit" do
    get edit_employee_hour_url(@employee_hour)
    assert_response :success
  end

  test "should update employee_hour" do
    patch employee_hour_url(@employee_hour), params: { employee_hour: {  } }
    assert_redirected_to employee_hour_url(@employee_hour)
  end

  test "should destroy employee_hour" do
    assert_difference('EmployeeHour.count', -1) do
      delete employee_hour_url(@employee_hour)
    end

    assert_redirected_to employee_hours_url
  end
end
