require 'test_helper'

class ResponsesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @response = responses(:one)
  end

  test "should get index" do
    get responses_url
    assert_response :success
  end

  test "should get new" do
    get new_response_url
    assert_response :success
  end

  test "should create response" do
    assert_difference('Response.count') do
      @response2 = @response
      post responses_url, params: { response: { answer_id: @response2.answer_id, lecture_id: @response2.lecture_id, question_id: @response2.question_id, user_id: @response2.user_id } }
    end

    assert_redirected_to response_url(Response.last)
  end

  test "should show response" do
    get response_url(@response)
    assert_response :success
  end

  test "should get edit" do
    get edit_response_url(@response)
    assert_response :success
  end

  test "should update response" do
    @response2 = @response
    patch response_url(@response2), params: { response: { answer_id: @response2.answer_id, lecture_id: @response2.lecture_id, question_id: @response2.question_id, user_id: @response2.user_id } }
    assert_redirected_to response_url(@response2)
  end

  test "should destroy response" do
    assert_difference('Response.count', -1) do
      delete response_url(@response)
    end

    assert_redirected_to responses_url
  end
end
