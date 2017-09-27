require 'test_helper'

class QuesAnswsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ques_answ = ques_answs(:one)
  end

  test "should get index" do
    get ques_answs_url
    assert_response :success
  end

  test "should get new" do
    get new_ques_answ_url
    assert_response :success
  end

  test "should create ques_answ" do
    assert_difference('QuesAnsw.count') do
      post ques_answs_url, params: { ques_answ: { answer: @ques_answ.answer, employee_id: @ques_answ.employee_id, question_id: @ques_answ.question_id } }
    end

    assert_redirected_to ques_answ_url(QuesAnsw.last)
  end

  test "should show ques_answ" do
    get ques_answ_url(@ques_answ)
    assert_response :success
  end

  test "should get edit" do
    get edit_ques_answ_url(@ques_answ)
    assert_response :success
  end

  test "should update ques_answ" do
    patch ques_answ_url(@ques_answ), params: { ques_answ: { answer: @ques_answ.answer, employee_id: @ques_answ.employee_id, question_id: @ques_answ.question_id } }
    assert_redirected_to ques_answ_url(@ques_answ)
  end

  test "should destroy ques_answ" do
    assert_difference('QuesAnsw.count', -1) do
      delete ques_answ_url(@ques_answ)
    end

    assert_redirected_to ques_answs_url
  end
end
