require 'test_helper'

class RegistrationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @registration = registrations(:one)
    @registration.role = 'STUDENT'
  end

  test "should get index" do
    get registrations_url
    assert_response :success
  end

  test "should get new" do
    get new_registration_url
    assert_response :success
  end

  test "should create registration" do
    assert_difference('Registration.count') do
      post registrations_url, params: { registration: { student_key: courses(:one).student_key } }
    end

    assert_redirected_to course_url(Registration.last.course)
  end

  test "should show registration" do
    get registration_url(@registration), params: {un: 'leahy'}
    assert_response :success
  end

  test "should get edit" do
    get edit_registration_url(@registration), params: {un: 'leahy'}
    assert_response :success
  end

  test "should update registration" do
    patch registration_url(@registration), params: { un: 'leahy', registration: {role: 'INSTRUCTOR'} }
    assert_redirected_to registration_url(@registration)
  end

  test "should destroy registration" do
    assert_difference('Registration.count', -1) do
      delete registration_url(@registration), params: {un: 'leahy'}
    end

    assert_redirected_to registrations_url
  end
end
