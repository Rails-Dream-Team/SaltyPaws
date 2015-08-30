require 'test_helper'

class PostsControllerTest < ActionController::TestCase
  def setup
    @topic = topics(:one)
    @post = posts(:one)
    @user = users(:admin)
    sign_in @user
  end

  class PostsGetLoggedIn < PostsControllerTest
    test "get index renders html" do
      get :index, topic_id: @topic
      assert_equal [@post], assigns(:posts)
      assert_response :success
    end

    test "get new renders html" do
      get :new, topic_id: @topic
      assert_instance_of Post, assigns(:post)
      assert_response :success
      assert_template :new
    end

    test "get edit renders html" do
      get :edit, topic_id: @topic, id: @post.id
      assert_response :success
      assert_template :edit
    end

    test "get show renders html" do
      get :show, topic_id: @topic, id: @post.id
      assert_response :success
      assert_template :show
    end
  end

  class PostsGetLoggedOut < PostsControllerTest
    def setup
      @topic = topics(:one)
      @post = posts(:one)
      @user = users(:admin)
    end

    test "get index redirects" do
      get :index, topic_id: @topic
      assert_redirected_to new_user_session_path
    end

    test "get new redirects" do
      get :new, topic_id: @topic
      assert_redirected_to new_user_session_path
    end

    test "get edit redirects" do
      get :edit, topic_id: @topic.id, id: @post.id
      assert_redirected_to new_user_session_path
    end

    test "get show redirects" do
      get :show, topic_id: @topic.id, id: @post.id
      assert_redirected_to new_user_session_path
    end
  end

  class PostsCreate < PostsControllerTest
    test 'creates with valid attributes and redirects' do
      old_replies = @topic.replies
      assert_difference('Post.count', 1) do
        post :create, topic_id: @topic,
                      post: { content: 'oh hai, look at my cool test post' }
      end
      @topic.reload
      assert_redirected_to topic_path(assigns(:topic))
      assert_equal(old_replies + 1, @topic.replies)
    end

    test 'renders new with invalid attribute submission (no content)' do
      assert_no_difference('Post.count') do
        post :create, topic_id: @topic, post: { content: '' }
      end
      assert_template :new
    end

    test 'redirects to login when logged out' do
      sign_out @user
      assert_no_difference('Post.count') do
        post :create, topic_id: @topic, post: { content: 'oh hai, look at my cool test post' }
      end
      assert_redirected_to new_user_session_path
    end
  end

  class PostsUpdate < PostsControllerTest
    test 'updates with valid attributes and redirects' do
      old_content = @post.content
      new_content = 'this new content is better'
      patch :update, topic_id: @topic, id: @post, post: { content: new_content }
      @post.reload
      assert_redirected_to topic_path(assigns(:topic))
      assert_equal new_content, @post.content
    end

    test 'renders edit with invalid attribute submission (no content)' do
      old_content = @post.content
      patch :update, topic_id: @topic, id: @post, post: { content: nil }
      @post.reload
      assert_template :edit
      assert_equal old_content, @post.content
    end

    test 'redirects to login when logged out' do
      sign_out @user
      old_content = @post.content
      patch :update, topic_id: @topic, id: @post, post: { content: 'some new content' }
      assert_redirected_to new_user_session_path
      assert_equal old_content, @post.content
    end
  end

  class PostsDelete < PostsControllerTest
    test 'soft deletes and redirects to topic when logged in' do
      old_unscoped = Post.unscoped.count
      assert_difference('Post.count', -1) do
        delete :destroy, topic_id: @topic, id: @post
      end
      @post.reload
      assert_redirected_to topic_path(assigns(:topic))
      assert_equal old_unscoped, Post.unscoped.count
      refute @post.deleted_at.nil?
    end

    test 'redirects to login when logged out' do
      sign_out @user
      old_deleted_at = @post.deleted_at
      assert_no_difference('Post.count') do
        delete :destroy, topic_id: @topic, id: @post
      end
      @post.reload
      assert_redirected_to new_user_session_path
      assert_equal old_deleted_at, @post.deleted_at
    end
  end
end
