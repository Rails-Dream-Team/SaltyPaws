require 'test_helper'

class BoardsControllerTest < ActionController::TestCase
  def setup
    @board = boards(:one)
    @attributes = Board.attribute_names
    @user = users(:one)
    sign_in @user
  end

  test "GET index html render" do
    get :index
    assert_equal [@board], assigns(:boards)
    assert_response :success
  end

  test "GET #new" do
    get :new
    assert_instance_of Board, assigns(:board)
    assert_response :success
  end

  test "GET #edit" do
    get :edit, id: @board.id
    assert_response :success
    assert_template(:edit)
  end

  test "GET #show" do
    get :show, id: @board.id
    assert_response :success
    assert_template(:show)
  end

  class BoardsCreate < BoardsControllerTest
    test 'creates with valid attributes and redirects' do
      assert_difference('Board.count', 1) do
        post :create, board: { title: 'fake board, being all fake and whatnot' }
      end
      assert_redirected_to board_path(assigns(:board))
    end

    test 'renders new with invalid attribute submission (no title)' do
      assert_no_difference('Board.count') do
        post :create, board_id: @board, board: { title: '' }
      end
      assert_template :new
    end
  end
end
