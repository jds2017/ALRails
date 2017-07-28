require 'test_helper'

class QuestionSetsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @question_set = question_sets(:one)
  end

  test "should get index" do
    get question_sets_url
    assert_response :success
  end

  test "should get new" do
    get new_question_set_url, params: {un: 'leahy', course_name: 'XX9999'}
    assert_response :success
  end

  test "should create question_set" do
    assert_difference('QuestionSet.count') do
      post question_sets_url, params: { un: 'leahy', question_set: { course_name: 'XX9999', is_readonly: @question_set.is_readonly, name: @question_set.name }, question_ids: [questions(:one).id.to_s] }
    end
    assert_redirected_to question_set_url(QuestionSet.last)
  end

  test "should show question_set" do
    get question_set_url(@question_set, params: {un: 'leahy'})
    assert_response :success
  end

  test "should get edit" do
    get edit_question_set_url(@question_set, params: {un: 'leahy'})
    assert_response :success
  end

  test "should update question_set" do
    patch question_set_url(@question_set), params: { un: 'leahy', question_set: { course_name: 'XX9999', is_readonly: @question_set.is_readonly, name: @question_set.name }, question_ids: [questions(:one).id.to_s] }
    assert_redirected_to question_set_url(@question_set)
  end

  test "should destroy question_set" do
    assert_difference('QuestionSet.count', -1) do
      delete question_set_url(@question_set, params: {un: 'leahy'})
    end
    assert_redirected_to question_sets_url
  end
end
