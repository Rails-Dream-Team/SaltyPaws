require 'test_helper'

class PostsControllerTest < ActionController::TestCase
  def setup
    @private_topic = topics(:one)
    @public_topic = topics(:four)
    @private_post = posts(:one)
    @priv_vol_post = posts(:two)
    @priv_bas_post = posts(:three)
    @public_post = posts(:four)
    @admin = users(:admin)
    @volunteer = users(:volunteer)
    @basic = users(:basic)
  end

  class PostsWhenAdmin < PostsControllerTest
    def setup
      super
      sign_in @admin
    end

    test "get index renders" do
      get :index, topic_id: @private_topic
      assert_equal [@private_post], assigns(:posts)
      assert_template :index
    end

    test "get new under private topic renders" do
      get :new, topic_id: @private_topic
      refute @private_topic.board.public
      assert_instance_of Post, assigns(:post)
      assert_template :new
    end

    test "get new under public topic renders" do
      get :new, topic_id: @public_topic
      assert @public_topic.board.public
      assert_instance_of Post, assigns(:post)
      assert_template :new
    end

    test "get edit of private post renders" do
      get :edit, topic_id: @private_topic, id: @private_post.id
      assert_template :edit
    end

    test "get edit of public post renders" do
      get :edit, topic_id: @public_topic, id: @public_post.id
      assert_template :edit
    end

    test "get show of private post renders" do
      get :show, topic_id: @private_topic, id: @private_post.id
      assert_template :show
    end

    test "get show of public post renders" do
      get :show, topic_id: @public_topic, id: @public_post.id
      assert_template :show
    end
  end # end PostsWhenAdmin

  class PostsCreate < PostsControllerTest
    def setup
      super
      sign_in @admin
    end

    test 'admin creates valid under private topic and redirects' do
      old_replies = @private_topic.replies
      assert_difference('Post.count', 1) do
        post :create, topic_id: @private_topic,
                      post: { content: 'oh hai, look at my cool test post' }
      end
      @private_topic.reload
      assert_redirected_to topic_path(assigns(:topic))
      assert_equal(old_replies + 1, @private_topic.replies)
    end

    test 'admin creates valid under public topic and redirects' do
      old_replies = @public_topic.replies
      assert_difference('Post.count', 1) do
        post :create, topic_id: @public_topic,
                      post: { content: 'oh hai, look at my cool test post' }
      end
      @public_topic.reload
      assert_redirected_to topic_path(assigns(:topic))
      assert_equal(old_replies + 1, @public_topic.replies)
    end

    test 'admin renders new with invalid attribute submission (no content)' do
      assert_no_difference('Post.count') do
        post :create, topic_id: @public_topic, post: { content: '' }
      end
      assert_template :new
    end

    test 'volunteer creates valid and redirects' do
      sign_in @volunteer
      old_replies = @private_topic.replies
      assert_difference('Post.count', 1) do
        post :create, topic_id: @private_topic,
                      post: { content: 'oh hai, look at my cool test post' }
      end
      @private_topic.reload
      assert_redirected_to topic_path(assigns(:topic))
      assert_equal(old_replies + 1, @private_topic.replies)
    end

    test 'basic creates valid and redirects' do
      sign_in @basic
      old_replies = @private_topic.replies
      assert_difference('Post.count', 1) do
        post :create, topic_id: @private_topic,
                      post: { content: 'oh hai, look at my cool test post' }
      end
      @private_topic.reload
      assert_redirected_to topic_path(assigns(:topic))
      assert_equal(old_replies + 1, @private_topic.replies)
    end

  end # end PostsCreate

  class PostsUpdate < PostsControllerTest
    def setup
      super
      sign_in @admin
    end

    test 'admin updates with valid attributes under private topic and redirects' do
      old_content = @private_post.content
      new_content = 'this new content is better'
      patch :update, topic_id: @private_topic, id: @private_post, post: { content: new_content }
      @private_post.reload
      assert_redirected_to topic_path(assigns(:topic))
      assert_equal new_content, @private_post.content
    end

    test 'admin updates with valid attributes under public topic and redirects' do
      old_content = @public_post.content
      new_content = 'this new content is better'
      patch :update, topic_id: @public_topic, id: @public_post, post: { content: new_content }
      @public_post.reload
      assert_redirected_to topic_path(assigns(:topic))
      assert_equal new_content, @public_post.content
    end

    test 'admin renders edit with invalid attribute submission (no content)' do
      old_content = @public_post.content
      patch :update, topic_id: @public_topic, id: @public_post, post: { content: nil }
      @public_post.reload
      assert_template :edit
      assert_equal old_content, @public_post.content
    end

    test 'volunteer updates with valid attr if created by current user' do
      sign_in @volunteer
      assert_equal @volunteer, @priv_vol_post.user
      old_content = @priv_vol_post.content
      new_content = 'this new content is better'
      patch :update, topic_id: @priv_vol_post.topic, id: @priv_vol_post, post: { content: new_content }
      @priv_vol_post.reload
      assert_redirected_to topic_path(assigns(:topic))
      assert_equal new_content, @priv_vol_post.content
    end

    test 'volunteer redirects if created by different user' do
      sign_in @volunteer
      refute @volunteer == @private_post.user
      old_content = @private_post.content
      new_content = 'this new content is better'
      patch :update, topic_id: @private_topic, id: @private_post, post: { content: new_content }
      @private_post.reload
      assert_redirected_to(request.referrer || root_path)
      assert_equal old_content, @private_post.content
    end

    test 'basic updates with valid attr if created by current user' do
      sign_in @basic
      assert_equal @basic, @priv_bas_post.user
      old_content = @priv_bas_post.content
      new_content = 'this new content is better'
      patch :update, topic_id: @priv_bas_post.topic, id: @priv_bas_post, post: { content: new_content }
      @priv_bas_post.reload
      assert_redirected_to topic_path(assigns(:topic))
      assert_equal new_content, @priv_bas_post.content
    end

    test 'basic redirects if created by different user' do
      sign_in @basic
      refute @basic == @private_post.user
      old_content = @private_post.content
      new_content = 'this new content is better'
      patch :update, topic_id: @private_topic, id: @private_post, post: { content: new_content }
      @private_post.reload
      assert_redirected_to(request.referrer || root_path)
      assert_equal old_content, @private_post.content
    end
  end # end PostsUpdate

  class PostsDelete < PostsControllerTest
    test 'admin soft deletes and redirects to topic when logged in' do
      sign_in @admin
      old_unscoped = Post.unscoped.count
      assert_difference('Post.count', -1) do
        delete :destroy, topic_id: @private_topic, id: @private_post
      end
      @private_post.reload
      assert_redirected_to topic_path(assigns(:topic))
      assert_equal old_unscoped, Post.unscoped.count
      refute @private_post.deleted_at.nil?
    end

    test 'volunteer redirects and does not delete' do
      sign_in @volunteer
      old_deleted_at = @priv_vol_post.deleted_at
      assert_no_difference('Post.count') do
        delete :destroy, topic_id: @priv_vol_post.topic, id: @priv_vol_post
      end
      @priv_vol_post.reload
      assert_equal old_deleted_at, @priv_vol_post.deleted_at
      assert_redirected_to(request.referrer || root_path)
    end

    test 'basic redirects and does not delete' do
      sign_in @basic
      old_deleted_at = @priv_bas_post.deleted_at
      assert_no_difference('Post.count') do
        delete :destroy, topic_id: @priv_bas_post.topic, id: @priv_bas_post
      end
      @priv_bas_post.reload
      assert_equal old_deleted_at, @priv_bas_post.deleted_at
      assert_redirected_to(request.referrer || root_path)
    end
  end # end PostsDelete

  class PostsWhenLoggedOut < PostsControllerTest
    test "get index redirects" do
      get :index, topic_id: @private_topic
      assert_redirected_to new_user_session_path
    end

    test "get new under private topic redirects" do
      get :new, topic_id: @private_topic
      assert_redirected_to new_user_session_path
    end

    test "get new under public topic renders" do
      get :new, topic_id: @public_topic
      assert_instance_of Post, assigns(:post)
      assert_template :new
    end

    test "get edit redirects" do
      get :edit, topic_id: @private_topic.id, id: @private_post.id
      assert_redirected_to new_user_session_path
    end

    test "get show under private topic redirects" do
      get :show, topic_id: @private_topic.id, id: @private_post.id
      assert_redirected_to(request.referrer || root_path)
    end

    test "get show under public topic renders" do
      get :show, topic_id: @public_topic.id, id: @public_post.id
      assert_equal @public_post, assigns(:post)
      assert_template :show
    end

    test 'post create redirects' do
      assert_no_difference('Post.count') do
        post :create, topic_id: @private_topic, post: { content: 'oh hai, look at my cool test post' }
      end
      assert_redirected_to new_user_session_path
    end

    test 'patch update redirects' do
      old_content = @private_post.content
      patch :update, topic_id: @private_topic, id: @private_post, post: { content: 'some new content' }
      assert_redirected_to new_user_session_path
      assert_equal old_content, @private_post.content
    end

    test 'delete destroy redirects' do
      old_deleted_at = @private_post.deleted_at
      assert_no_difference('Post.count') do
        delete :destroy, topic_id: @private_topic, id: @private_post
      end
      @private_post.reload
      assert_redirected_to new_user_session_path
      assert_equal old_deleted_at, @private_post.deleted_at
    end
  end # end PostsWhenLoggedOut
end
