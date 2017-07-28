require 'test_helper'

class LecturesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @lecture = lectures(:one)
  end

  test "should get new" do
    get new_lecture_url, params: {un: 'leahy', course_id: courses(:one).id}
    assert_response :success
  end

  test "should create lecture" do
    assert_difference('Lecture.count') do
      post lectures_url, params: { un: 'leahy', course_id: courses(:one).id, lecture: { question_set_id: @lecture.question_set_id, title: @lecture.title } }
    end
    assert_redirected_to course_url(courses(:one))
    assert courses(:one).lectures.include? @lecture
  end

  test "should show lecture" do
    get lecture_url(@lecture, params: {un: 'leahy'})
    assert_response :success
  end

  test "should get edit" do
    get edit_lecture_url(@lecture, params: {un: 'leahy', course_id: courses(:one).id})
    assert_response :success
  end

  test "should update lecture" do
    patch lecture_url(@lecture), params: { un: 'leahy', course_id: courses(:one).id, lecture: { question_set_id: @lecture.question_set_id, title: @lecture.title } }
    assert_redirected_to lecture_url(@lecture)
  end

  test "should destroy lecture" do
    assert_difference('Lecture.count', -1) do
      delete lecture_url(@lecture, params: {un: 'leahy', course_id: courses(:one).id})
    end
    assert_redirected_to lectures_url
  end
end
