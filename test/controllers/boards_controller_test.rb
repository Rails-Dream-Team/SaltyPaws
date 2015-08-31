require 'test_helper'

class BoardsControllerTest < ActionController::TestCase
  def setup
    @private_board = boards(:one)
    @public_board = boards(:two)
    @all_boards = [@private_board, @public_board]
    @admin = users(:admin)
    @volunteer = users(:volunteer)
    @basic = users(:basic)
    @attributes = Board.column_names
  end

  class BoardsWhenAdmin < BoardsControllerTest
    def setup
      super
      sign_in @admin
    end

    test "html gets index" do
      get :index
      assert_equal @all_boards, assigns(:boards)
      assert_template :index
    end

    test "json gets index" do
      get :index, format: :json
      response_item = JSON.parse(response.body)
      @attributes.each do |a|
        @all_boards.each_index do |i|
          assert_equal @all_boards[i].send(a), response_item[i][a]
        end
      end
      assert_response :success
    end

    test "html gets new" do
      get :new
      assert_instance_of Board, assigns(:board)
      assert_template :new
    end

    test "html gets edit for private" do
      get :edit, id: @private_board.id
      assert_template :edit
    end

    test "html gets edit for public" do
      get :edit, id: @public_board.id
      assert_template :edit
    end

    test "html gets show for private" do
      get :show, id: @private_board.id
      assert_template :show
    end

    test "html gets show for public" do
      get :show, id: @public_board.id
      assert_template :show
    end

    test "json gets show for private" do
      get :show, id: @private_board.id, format: :json
      response_item = JSON.parse(response.body)
      @attributes.each do |a|
        assert_equal @private_board.send(a), response_item[a]
      end
      assert_response :success
    end
  end # end of BoardsWhenAdmin

  class BoardsWhenVolunteer < BoardsControllerTest
    def setup
      super
      sign_in @volunteer
    end

    test "html gets index" do
      get :index
      assert_equal @all_boards, assigns(:boards)
      assert_template :index
    end

    test "html get new redirects" do
      get :new
      assert_instance_of Board, assigns(:board)
      assert_redirected_to(request.referrer || root_path)
    end

    test "html get edit redirects for private" do
      get :edit, id: @private_board.id
      assert_redirected_to(request.referrer || root_path)
    end

    test "html get edit redirects for public" do
      get :edit, id: @public_board.id
      assert_redirected_to(request.referrer || root_path)
    end

    test "html gets show for private" do
      get :show, id: @private_board.id
      assert_template :show
    end

    test "html gets show for public" do
      get :show, id: @public_board.id
      assert_template :show
    end
  end # end of BoardsWhenVolunteer

  class BoardsWhenBasic < BoardsControllerTest
    def setup
      super
      sign_in @basic
    end

    test "html gets index" do
      get :index
      assert_equal @all_boards, assigns(:boards)
      assert_template :index
    end

    test "html get new redirects" do
      get :new
      assert_instance_of Board, assigns(:board)
      assert_redirected_to(request.referrer || root_path)
    end

    test "html get edit redirects for private" do
      get :edit, id: @private_board.id
      assert_redirected_to(request.referrer || root_path)
    end

    test "html get edit redirects for public" do
      get :edit, id: @public_board.id
      assert_redirected_to(request.referrer || root_path)
    end

    test "html gets show for private" do
      get :show, id: @private_board.id
      assert_template :show
    end

    test "html gets show for public" do
      get :show, id: @public_board.id
      assert_template :show
    end
  end # end of BoardsWhenBasic

  class BoardsCreate < BoardsControllerTest
    test 'admin creates with valid attributes and redirects' do
      sign_in @admin
      assert_difference('Board.count', 1) do
        post :create, board: { title: 'fake board, being all fake and whatnot' }
      end
      assert_redirected_to board_path(assigns(:board))
    end

    test 'admin renders new with invalid attribute submission (no title)' do
      sign_in @admin
      assert_no_difference('Board.count') do
        post :create, board: { title: '' }
      end
      assert_template :new
    end

    test 'volunteer redirects and does not create' do
      sign_in @volunteer
      assert_no_difference('Board.count') do
        post :create, board: { title: 'some valid title' }
      end
      assert_redirected_to(request.referrer || root_path)
    end

    test 'basic redirects and does not create' do
      sign_in @basic
      assert_no_difference('Board.count') do
        post :create, board: { title: 'some valid title' }
      end
      assert_redirected_to(request.referrer || root_path)
    end
  end # end of BoardsCreate

  class BoardsUpdate < BoardsControllerTest
    test 'admin updates with valid attributes and redirects' do
      sign_in @admin
      old_title = @private_board.title
      new_title = 'this new title is better'
      patch :update, id: @private_board, board: { title: new_title }
      @private_board.reload
      assert_redirected_to board_path(assigns(:board))
      assert_equal new_title, @private_board.title
    end

    test 'admin renders edit with invalid attribute submission (no title)' do
      sign_in @admin
      old_title = @private_board.title
      patch :update, id: @private_board, board: { title: '' }
      @private_board.reload
      assert_template :edit
      assert_equal old_title, @private_board.title
    end

    test 'volunteer redirects and does not update' do
      sign_in @volunteer
      old_title = @private_board.title
      new_title = 'this new title is better'
      patch :update, id: @private_board, board: { title: new_title }
      @private_board.reload
      assert_redirected_to(request.referrer || root_path)
      assert_equal old_title, @private_board.title
    end

    test 'basic redirects and does not update' do
      sign_in @basic
      old_title = @private_board.title
      new_title = 'this new title is better'
      patch :update, id: @private_board, board: { title: new_title }
      @private_board.reload
      assert_redirected_to(request.referrer || root_path)
      assert_equal old_title, @private_board.title
    end
  end # end of BoardsUpdate

  class BoardsDelete < BoardsControllerTest
    test 'admin soft deletes and redirects to boards index' do
      sign_in @admin
      old_unscoped = Board.unscoped.count
      assert_difference('Board.count', -1) do
        delete :destroy, id: @private_board
      end
      @private_board.reload
      assert_redirected_to boards_path
      assert_equal old_unscoped, Board.unscoped.count
      refute @private_board.deleted_at.nil?
    end

    test 'volunteer redirects and does not delete' do
      sign_in @volunteer
      old_deleted_at = @private_board.deleted_at
      assert_no_difference('Board.count') do
        delete :destroy, id: @private_board
      end
      @private_board.reload
      assert_equal old_deleted_at, @private_board.deleted_at
      assert_redirected_to(request.referrer || root_path)
    end

    test 'basic redirects and does not delete' do
      sign_in @basic
      old_deleted_at = @private_board.deleted_at
      assert_no_difference('Board.count') do
        delete :destroy, id: @private_board
      end
      @private_board.reload
      assert_equal old_deleted_at, @private_board.deleted_at
      assert_redirected_to(request.referrer || root_path)
    end
  end # end of BoardsDelete

  class BoardsWhenLoggedOut < BoardsControllerTest
    test "get index redirects" do
      get :index
      assert_equal [@public_board], assigns(:boards)
      assert_template :index
    end

    test "get new redirects" do
      get :new
      assert_redirected_to new_user_session_path
    end

    test "get edit redirects" do
      get :edit, id: @public_board
      assert_redirected_to new_user_session_path
    end

    test "get show of private with html redirects" do
      get :show, id: @private_board
      assert_redirected_to(request.referrer || root_path)
    end

    test "get show of public with html renders" do
      get :show, id: @public_board
      assert_template :show
    end

    test 'post create redirects' do
      assert_no_difference('Board.count') do
        post :create, board: { title: 'fake board, being all fake and whatnot' }
      end
      assert_redirected_to new_user_session_path
    end

    test 'patch update redirects' do
      old_title = @public_board.title
      patch :update, id: @public_board, board: { title: 'this is a new title' }
      assert_redirected_to new_user_session_path
      assert_equal old_title, @public_board.title
    end

    test 'delete destroy redirects' do
      old_deleted_at = @public_board.deleted_at
      assert_no_difference('Board.count') do
        delete :destroy, id: @public_board
      end
      @public_board.reload
      assert_redirected_to new_user_session_path
      assert_equal old_deleted_at, @public_board.deleted_at
    end
  end # end of BoardsWhenLoggedOut
end
