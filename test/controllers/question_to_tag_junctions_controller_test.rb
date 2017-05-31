require 'test_helper'

class QuestionToTagJunctionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @question_to_tag_junction = question_to_tag_junctions(:one)
  end

  test "should get index" do
    get question_to_tag_junctions_url
    assert_response :success
  end

  test "should get new" do
    get new_question_to_tag_junction_url
    assert_response :success
  end

  test "should create question_to_tag_junction" do
    assert_difference('QuestionToTagJunction.count') do
      post question_to_tag_junctions_url, params: { question_to_tag_junction: { question_id: @question_to_tag_junction.question_id, tag_id: @question_to_tag_junction.tag_id } }
    end

    assert_redirected_to question_to_tag_junction_url(QuestionToTagJunction.last)
  end

  test "should show question_to_tag_junction" do
    get question_to_tag_junction_url(@question_to_tag_junction)
    assert_response :success
  end

  test "should get edit" do
    get edit_question_to_tag_junction_url(@question_to_tag_junction)
    assert_response :success
  end

  test "should update question_to_tag_junction" do
    patch question_to_tag_junction_url(@question_to_tag_junction), params: { question_to_tag_junction: { question_id: @question_to_tag_junction.question_id, tag_id: @question_to_tag_junction.tag_id } }
    assert_redirected_to question_to_tag_junction_url(@question_to_tag_junction)
  end

  test "should destroy question_to_tag_junction" do
    assert_difference('QuestionToTagJunction.count', -1) do
      delete question_to_tag_junction_url(@question_to_tag_junction)
    end

    assert_redirected_to question_to_tag_junctions_url
  end
end
