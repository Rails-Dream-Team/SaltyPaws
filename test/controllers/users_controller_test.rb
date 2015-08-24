require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  def setup
    @user = users(:one)
  end

  test "GET edit with html" do
    get :edit, id: @user
    assert_equal @user, assigns(:user)
    assert_response :success
  end

  test "PATCH update with html" do
    old_name = @user.display_name
    new_name = "New User1"
    patch :update, id: @user, user: { display_name: new_name }
    @user.reload
    refute @user.display_name == old_name
    assert_redirected_to user_path(@user)
  end

  test "PATCH update with json" do
    patch :update, format: :json, id: @user, user: { display_name: "New User" }
    assert_response :success
  end

end
