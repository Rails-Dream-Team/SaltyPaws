require 'test_helper'

class TopicsControllerTest < ActionController::TestCase
  def setup
    @board = boards(:one)
    @topic = topics(:one)
    @user = users(:admin)
    sign_in @user
  end

  class TopicsWhenLoggedIn < TopicsControllerTest
    test "get index renders html" do
      get :index
      assert_equal [@topic], assigns(:topics)
      assert_response :success
    end

    test "get new renders html" do
      get :new
      assert_instance_of Topic, assigns(:topic)
      assert_response :success
      assert_template :new
    end

    test "get edit renders html" do
      get :edit, id: @topic.id
      assert_response :success
      assert_template :edit
    end

    test "get show renders html" do
      get :show, id: @topic.id
      assert_response :success
      assert_template :show
    end
  end

  class TopicsWhenLoggedOut < TopicsControllerTest
    def setup
      @board = boards(:one)
      @topic = topics(:one)
      @user = users(:admin)
    end

    test "get index redirects" do
      get :index
      assert_redirected_to new_user_session_path
    end

    test "get new redirects" do
      get :new
      assert_redirected_to new_user_session_path
    end

    test "get edit redirects" do
      get :edit, id: @topic.id
      assert_redirected_to new_user_session_path
    end

    test "get show redirects" do
      get :show, id: @topic.id
      assert_redirected_to new_user_session_path
    end
  end

  class TopicsCreate < TopicsControllerTest
    test 'creates with valid attributes and redirects' do
      assert_difference('Topic.count', 1) do
        post :create, topic: { title: 'fake topic, being all fake and whatnot', board_id: @board }
      end
      assert_redirected_to topic_path(assigns(:topic))
    end

    test 'renders new with invalid attribute submission (no title)' do
      assert_no_difference('Topic.count') do
        post :create, topic: { title: '', board_id: @board }
      end
      assert_template :new
    end

    test 'renders new with invalid attribute submission (no board)' do
      assert_no_difference('Topic.count') do
        post :create, topic: { title: 'fake topic, being all fake and whatnot', board_id: nil }
      end
      assert_template :new
    end

    test 'redirects to login when no user logged in' do
      sign_out @user
      assert_no_difference('Topic.count') do
        post :create, topic: { title: 'fake topic, being all fake and whatnot' }
      end
      assert_redirected_to new_user_session_path
    end
  end

  class TopicsUpdate < TopicsControllerTest
    test 'updates with valid attributes and redirects' do
      old_title = @topic.title
      new_title = 'fake title, now with more fake'
      patch :update, id: @topic, topic: { title: new_title }
      @topic.reload
      assert_redirected_to topic_path(assigns(:topic))
      assert_equal new_title, @topic.title
    end

    test 'renders edit with invalid attribute submission (no title)' do
      old_title = @topic.title
      patch :update, id: @topic, topic: { title: nil }
      @topic.reload
      assert_equal old_title, @topic.title
      assert_template :edit
    end

    test 'renders edit with invalid attribute submission (no board)' do
      old_board = @topic.board
      patch :update, id: @topic, topic: { board_id: nil }
      @topic.reload
      assert_equal old_board, @topic.board
      assert_template :edit
    end

    test 'redirects to login when no user logged in' do
      sign_out @user
      old_title = @topic.title
      patch :update, id: @topic, topic: { title: 'fake topic, being all fake and whatnot' }
      assert_redirected_to new_user_session_path
      assert_equal old_title, @topic.title
    end
  end

  class TopicsDelete < TopicsControllerTest
    test 'soft deletes and redirects to topics when logged in' do
      old_unscoped = Topic.unscoped.count
      assert_difference('Topic.count', -1) do
        delete :destroy, id: @topic
      end
      @topic.reload
      assert_redirected_to topics_path
      assert_equal old_unscoped, Topic.unscoped.count
      refute @topic.deleted_at.nil?
    end

    test 'redirects to login when logged out' do
      sign_out @user
      old_deleted_at = @topic.deleted_at
      assert_no_difference('Topic.count') do
        delete :destroy, id: @topic
      end
      @topic.reload
      assert_redirected_to new_user_session_path
      assert_equal old_deleted_at, @topic.deleted_at
    end
  end
end
