require 'test_helper'

class TopicsControllerTest < ActionController::TestCase
  def setup
    @topic = topics(:one)
    @attributes = Topic.attribute_names
  end

  test "GET index html render" do
    get :index
    assert_equal [@topic], assigns(:topics)
    assert_response :success
  end

  # test "GET index json render" do
  #   get :index, format: :json
  #   response_item = JSON.parse(response.body)[0]
  #   @attributes.each do |attr|
  #     assert_equal @topic.send(attr), response_item[attr]
  #   end
  #   assert_response :success
  # end

  test "GET #new" do
    get :new
    assert_instance_of Topic, assigns(:topic)
    assert_response :success
  end

  test "GET #edit" do
    get :edit, id: @topic.id
    assert_response :success
    assert_template(:edit)
  end

  test "GET #show" do
    get :show, id: @topic.id
    assert_response :success
    assert_template(:show)
  end
end
