require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test "should get index" do
    get users_url, params: {un: 'john'}
    assert_response :success
  end

  test "should get new" do
    get new_user_url, params: {un: 'john'}
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      get courses_url, params: { un: 'tocreate' }
    end
  end

  test "should show user" do
    get user_url(@user), params: {un: 'john'}
    assert_response :success
  end

  test "should get edit" do
    get edit_user_url(@user, params: {un: 'john'})
    assert_response :success
  end

  test "should update user" do
    patch user_url(@user), params: { user: { fname: @user.fname, is_admin: @user.is_admin, lname: @user.lname, username: @user.username }, un: 'john' }
    assert_redirected_to user_url(@user)
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete user_url(@user), params: {un: 'john'}
    end

    assert_redirected_to users_url
  end
end
