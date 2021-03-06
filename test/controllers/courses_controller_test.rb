require 'test_helper'

class CoursesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @course = courses(:one)
    @course.semester = 'SUMMER'
  end

  test "should get index" do
    get courses_url
    assert_response :success
  end

  test "should get new" do
    get new_course_url, params: {un: 'leahy'}
    assert_response :success
  end

  test "should create course" do
    assert_difference('Course.count') do
      post courses_url, params: { course: { name: @course.name, semester: @course.semester, student_key: @course.student_key, year: @course.year }, un: 'leahy' }
    end
    assert_redirected_to course_url(Course.last)
  end

  test "should show course" do
    get course_url(@course, params: {un: 'leahy'})
    assert_response :success
  end

  test "should get edit" do
    get edit_course_url(@course, params: {un: 'leahy'})
    assert_response :success
  end

  test "should update course" do
    patch course_url(@course), params: { course: { name: @course.name, semester: @course.semester, student_key: @course.student_key, year: @course.year }, un: 'leahy' }
    assert_redirected_to course_url(@course)
  end

  test "should destroy course" do
    assert_difference('Course.count', -1) do
      delete course_url(@course, params: {un: 'leahy'})
    end
    assert_redirected_to courses_url
  end
end
