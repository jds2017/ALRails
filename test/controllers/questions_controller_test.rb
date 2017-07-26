require 'test_helper'

class QuestionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @question = questions(:one)
  end

  test "should get index" do
    get questions_url
    assert_response :success
  end

  test "should get new" do
    get new_question_url
    assert_response :success
  end

  test "should create question" do
    assert_difference('Question.count') do
      post questions_url, params: { question: { body: @question.body, course_name: @question.course_name } }
    end

    assert_redirected_to question_url(Question.last)
  end

  test "should show question" do
    get question_url(@question, params: {un: 'leahy'})
    assert_response :success
  end

  test "should get edit" do
    get edit_question_url(@question, params: {un: 'leahy'})
    assert_response :success
  end

  test "should update question" do
    patch question_url(@question), params: { un: 'leahy', tags_list: 'malloc, malloc', question: { body: @question.body } }
    assert_redirected_to question_url(@question)
    assert_equal 1, @question.tags.size
  end

  test "should destroy question" do
    assert_difference('Question.count', -1) do
      delete question_url(@question, params: {un: 'leahy'})
    end
    assert_redirected_to questions_url
  end
end
