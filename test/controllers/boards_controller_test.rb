require 'test_helper'

class BoardsControllerTest < ActionController::TestCase
  def setup
    @board = boards(:one)
    @user = users(:one)
    sign_in @user
  end

  class BoardsWhenLoggedIn < BoardsControllerTest

    test "get index renders html" do
      get :index
      assert_equal [@board], assigns(:boards)
      assert_response :success
    end

    test "get new renders html" do
      get :new
      assert_instance_of Board, assigns(:board)
      assert_response :success
    end

    test "get edit renders html" do
      get :edit, id: @board.id
      assert_response :success
      assert_template(:edit)
    end

    test "get show renders html" do
      get :show, id: @board.id
      assert_response :success
      assert_template(:show)
    end
  end

  class BoardsWhenLoggedOut < BoardsControllerTest
    def setup
      @board = boards(:one)
      @user = users(:one)
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
      get :edit, id: @board.id
      assert_redirected_to new_user_session_path
    end

    test "get show redirects" do
      get :show, id: @board.id
      assert_redirected_to new_user_session_path
    end
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

    test 'redirects to login when no user logged in' do
      sign_out @user
      assert_no_difference('Board.count') do
        post :create, board: { title: 'fake board, being all fake and whatnot' }
      end
      assert_redirected_to new_user_session_path
    end
  end

  class BoardsUpdate < BoardsControllerTest
    test 'updates with valid attributes and redirects' do
      old_title = @board.title
      new_title = 'this new title is better'
      patch :update, id: @board, board: { title: new_title }
      @board.reload
      assert_redirected_to board_path(assigns(:board))
      assert_equal new_title, @board.title
    end

    test 'renders edit with invalid attribute submission (no title)' do
      old_title = @board.title
      patch :update, id: @board, board: { title: nil }
      @board.reload
      assert_template :edit
      assert_equal old_title, @board.title
    end

    test 'redirects to login when no user logged in' do
      sign_out @user
      old_title = @board.title
      patch :update, id: @board, board: { title: 'this is a new title' }
      assert_redirected_to new_user_session_path
      assert_equal old_title, @board.title
    end
  end

  class BoardsDelete < BoardsControllerTest
    test 'soft deletes and redirects to boards index when logged in' do
      old_unscoped = Board.unscoped.count
      assert_difference('Board.count', -1) do
        delete :destroy, id: @board
      end
      @board.reload
      assert_redirected_to boards_path
      assert_equal old_unscoped, Board.unscoped.count
      refute @board.deleted_at.nil?
    end

    test 'redirects to login when no user logged in' do
      sign_out @user
      old_deleted_at = @board.deleted_at
      assert_no_difference('Board.count') do
        delete :destroy, id: @board
      end
      @board.reload
      assert_redirected_to new_user_session_path
      assert_equal old_deleted_at, @board.deleted_at
    end
  end
end
