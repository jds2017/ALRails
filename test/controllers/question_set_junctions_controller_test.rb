require 'test_helper'

class QuestionSetJunctionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @question_set_junction = question_set_junctions(:one)
  end

  test "should get index" do
    get question_set_junctions_url
    assert_response :success
  end

  test "should get new" do
    get new_question_set_junction_url
    assert_response :success
  end

  test "should create question_set_junction" do
    assert_difference('QuestionSetJunction.count') do
      post question_set_junctions_url, params: { question_set_junction: { question_id: @question_set_junction.question_id, question_set_id: @question_set_junction.question_set_id } }
    end

    assert_redirected_to question_set_junction_url(QuestionSetJunction.last)
  end

  test "should show question_set_junction" do
    get question_set_junction_url(@question_set_junction)
    assert_response :success
  end

  test "should get edit" do
    get edit_question_set_junction_url(@question_set_junction)
    assert_response :success
  end

  test "should update question_set_junction" do
    patch question_set_junction_url(@question_set_junction), params: { question_set_junction: { question_id: @question_set_junction.question_id, question_set_id: @question_set_junction.question_set_id } }
    assert_redirected_to question_set_junction_url(@question_set_junction)
  end

  test "should destroy question_set_junction" do
    assert_difference('QuestionSetJunction.count', -1) do
      delete question_set_junction_url(@question_set_junction)
    end

    assert_redirected_to question_set_junctions_url
  end
end
