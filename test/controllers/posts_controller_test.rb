require 'test_helper'

class PostsControllerTest < ActionController::TestCase
  def setup
    @topic = topics(:one)
    @post = posts(:one)
    @attributes = Post.attribute_names
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
end
