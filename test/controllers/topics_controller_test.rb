require 'test_helper'

class TopicsControllerTest < ActionController::TestCase
  def setup
    @topic = topics(:one)
    @user = users(:one)
    sign_in @user
    @board = boards(:one)
  end

  test "GET index html render" do
    get :index
    assert_equal [@topic], assigns(:topics)
    assert_response :success
  end

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

  class TopicsCreate < TopicsControllerTest
    test 'creates with valid attributes and redirects' do
      assert_difference('Topic.count', 1) do
        post :create, topic: { title: 'fake topic, being all fake and whatnot', board_id: @board }
      end
      assert_redirected_to topic_path(assigns(:topic))
    end

    test 'renders new with invalid attribute submission (no title)' do
      assert_no_difference('Topic.count') do
        post :create, topic_id: @topic, topic: { title: '' }
      end
      assert_template :new
    end

    test 'renders new with invalid attribute submission (no board)' do
      assert_no_difference('Topic.count') do
        post :create, topic_id: @topic, topic: { title: 'fake topic, being all fake and whatnot', board_id: nil }
      end
      assert_template :new
    end

    test 'redirects to login with invalid attribute submission (no user)' do
      sign_out @user
      assert_no_difference('Topic.count') do
        post :create, topic_id: @topic, topic: { title: 'fake topic, being all fake and whatnot', user_id: nil }
      end
      assert_redirected_to new_user_session_path
    end
  end

end
