require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  def setup
    @user1 = users(:one)
    sign_in @user1
    @user2 = users(:two)
    @attributes = ['id', 'first_name', 'last_name', 'display_name', 'email']
  end

  test "GET show with html for current user profile" do
    get :show, id: @user1
    assert_equal @user1, assigns(:user)
    assert_response :success
  end

  test "GET show with json for current user profile" do
    get :show, id: @user1, format: :json
    response_item = JSON.parse(response.body)
    @attributes.each do |a|
      assert_equal @user1.send(a), response_item[a]
    end
    assert_response :success
  end

  test "GET show with html for not-current user profile" do
    get :show, id: @user1
    assert_equal @user1, assigns(:user)
    assert_response :success
  end

  test "GET show with json for not-current user profile" do
    get :show, id: @user1, format: :json
    assert_equal @user1, assigns(:user)
    assert_response :success
  end

  test "GET edit with html" do
    get :edit, id: @user1
    assert_equal @user1, assigns(:user)
    assert_response :success
  end

  test "PATCH update with html" do
    old_name = @user1.display_name
    new_name = "New User1"
    patch :update, id: @user1, user: { display_name: new_name }
    @user1.reload
    refute @user1.display_name == old_name
    assert_redirected_to user_path(@user1)
  end

  test "PATCH update with json" do
    old_name = @user1.display_name
    new_name = "New User1"
    patch :update, format: :json, id: @user1, user: { display_name: new_name }
    @user1.reload
    assert_response :success
    assert_equal new_name, @user1.display_name
  end

end
