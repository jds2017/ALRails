require 'test_helper'

class CourseToLectureJunctionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @course_to_lecture_junction = course_to_lecture_junctions(:one)
  end

  test "should get index" do
    get course_to_lecture_junctions_url
    assert_response :success
  end

  test "should get new" do
    get new_course_to_lecture_junction_url
    assert_response :success
  end

  test "should create course_to_lecture_junction" do
    assert_difference('CourseToLectureJunction.count') do
      post course_to_lecture_junctions_url, params: { course_to_lecture_junction: { course_id: @course_to_lecture_junction.course_id, lecture_id: @course_to_lecture_junction.lecture_id } }
    end

    assert_redirected_to course_to_lecture_junction_url(CourseToLectureJunction.last)
  end

  test "should show course_to_lecture_junction" do
    get course_to_lecture_junction_url(@course_to_lecture_junction)
    assert_response :success
  end

  test "should get edit" do
    get edit_course_to_lecture_junction_url(@course_to_lecture_junction)
    assert_response :success
  end

  test "should update course_to_lecture_junction" do
    patch course_to_lecture_junction_url(@course_to_lecture_junction), params: { course_to_lecture_junction: { course_id: @course_to_lecture_junction.course_id, lecture_id: @course_to_lecture_junction.lecture_id } }
    assert_redirected_to course_to_lecture_junction_url(@course_to_lecture_junction)
  end

  test "should destroy course_to_lecture_junction" do
    assert_difference('CourseToLectureJunction.count', -1) do
      delete course_to_lecture_junction_url(@course_to_lecture_junction)
    end

    assert_redirected_to course_to_lecture_junctions_url
  end
end
