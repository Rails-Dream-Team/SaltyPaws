require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  def setup
    @user1 = users(:admin)
    sign_in @user1
    @user2 = users(:volunteer)
    @attributes = [
      'id',       'first_name',
      'email',    'last_name',
      'age',      'display_name',
      'phone',    'street_address',
      'city',     'state',
      'zip',      'facebook',
      'twitter',  'instagram',
      'pets',     'about_me',
      'role',     'volunteer_work',
      'admin'
    ]
  end

  class UserShow < UsersControllerTest
    test "html GETs show for current user profile" do
      get :show, id: @user1
      assert_equal @user1, assigns(:user)
      assert_template :show
    end

    test "json GETs show for current user profile" do
      get :show, id: @user1, format: :json
      response_item = JSON.parse(response.body)
      @attributes.each do |a|
        assert_equal @user1.send(a), response_item[a]
      end
      assert_response :success
    end

    test "html GETs show for different user profile when logged in" do
      get :show, id: @user2
      assert_equal @user2, assigns(:user)
      assert_template :show
    end

    test "json GETs show for different user profile when logged in" do
      get :show, id: @user2, format: :json
      response_item = JSON.parse(response.body)
      @attributes.each do |a|
        assert_equal @user2.send(a), response_item[a]
      end
      assert_response :success
    end

    test "html GET redirects to login if logged out" do
      sign_out @user1
      get :show, id: @user1
      assert_redirected_to new_user_session_path, 'html request should redirect'
    end

    test "json GET responds with unauthorized if logged out" do
      sign_out @user1
      get :show, id: @user1, format: :json
      assert_response :unauthorized
    end
  end

  class UsersEditUpdate < UsersControllerTest
    test "html GETs edit for current user when logged in" do
      get :edit, id: @user1
      assert_equal @user1, assigns(:user)
      assert_template :edit
    end

    test "html GET edit redirects to login when logged out" do
      sign_out @user1
      get :edit, id: @user1
      assert_redirected_to new_user_session_path
    end

    test "html PATCHes for current user when logged in" do
      old_name = @user1.display_name
      new_name = "My new name is better than my old name"
      patch :update, id: @user1, user: { display_name: new_name }
      @user1.reload
      assert_equal new_name, @user1.display_name
      assert_redirected_to user_path(@user1)
    end

    test "json PATCHes and responds successful when logged in" do
      old_name = @user1.display_name
      new_name = "My new name is better than my old name"
      patch :update, format: :json, id: @user1, user: { display_name: new_name }
      @user1.reload
      assert_equal new_name, @user1.display_name
      assert_response :success
    end

    test "html PATCH for different user renders profile when logged in" do
      old_name = @user2.display_name
      new_name = "I'm in your profile, editing your name"
      patch :update, id: @user2, user: { display_name: new_name }
      @user2.reload
      assert_equal old_name, @user2.display_name
      assert_redirected_to user_path(@user2)
    end

    test "json PATCH for different user responds unauthorized when logged in" do
      old_name = @user2.display_name
      new_name = "I'm in your profile, editing your name"
      patch :update, format: :json, id: @user2, user: { display_name: new_name }
      @user2.reload
      assert_equal old_name, @user2.display_name
      assert_response :unauthorized
    end

    test "html PATCH redirects to login when logged out" do
      sign_out @user1
      old_name = @user1.display_name
      new_name = "My new name is better than my old name"
      patch :update, id: @user1, user: { display_name: new_name }
      @user1.reload
      assert_equal old_name, @user1.display_name
      assert_redirected_to new_user_session_path
    end

    test "json PATCH responds unauthorized when logged out" do
      sign_out @user1
      old_name = @user1.display_name
      new_name = "My new name is better than my old name"
      patch :update, format: :json, id: @user1, user: { display_name: new_name }
      @user1.reload
      assert_equal old_name, @user1.display_name
      assert_response :unauthorized
    end

  end

end
