require 'test_helper'

class PostsControllerTest < ActionController::TestCase
  def setup
    @topic = topics(:one)
    @post = posts(:one)
    @user = users(:one)
    sign_in @user
    # @attributes = Post.attribute_names
  end

  test "GET index html render" do
    get :index, topic_id: @topic
    assert_equal [@post], assigns(:posts)
    assert_response :success
  end

  # test "GET index json render" do
  #   get :index, topic_id: @topic, format: :json
  #   response_item = JSON.parse(response.body)[0]
  #   @attributes.each do |attr|
  #     assert_equal @post.send(attr), response_item[attr]
  #   end
  #   assert_response :success
  # end

  test "GET #new" do
    get :new, topic_id: @topic
    assert_instance_of Post, assigns(:post)
    assert_response :success
  end

  test "GET #edit" do
    get :edit, topic_id: @topic, id: @post.id
    assert_response :success
    assert_template(:edit)
  end

  test "GET #show" do
    get :show, topic_id: @topic, id: @post.id
    assert_response :success
    assert_template(:show)
  end

  class PostsCreate < PostsControllerTest
    test 'creates with valid attributes and redirects' do
      assert_difference('Post.count', 1) do
        post :create, topic_id: @topic,
                      post: { content: 'oh hai, look at my cool test post' }
      end
      assert_redirected_to topic_path(assigns(:topic))
    end

    test 'renders new with invalid attribute submission (no content)' do
      assert_no_difference('Post.count') do
        post :create, topic_id: @topic, post: { content: '' }
      end
      assert_template :new
    end

    test 'redirects to login with invalid attribute submission (no user)' do
      sign_out @user
      assert_no_difference('Post.count') do
        post :create, topic_id: @topic, post: { content: 'oh hai, look at my cool test post', user_id: nil }
      end
      assert_redirected_to new_user_session_path
    end
  end

end
