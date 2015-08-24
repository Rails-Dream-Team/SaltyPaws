require 'test_helper'

class BoardsControllerTest < ActionController::TestCase
  def setup
    @board = boards(:one)
    @attributes = Board.attribute_names
  end

  test "GET index html render" do
    get :index
    assert_equal [@board], assigns(:boards)
    assert_response :success
  end

  # test "GET index json render" do
  #   get :index, format: :json
  #   response_item = JSON.parse(response.body)[0]
  #   @attributes.each do |attr|
  #     assert_equal @board.send(attr), response_item[attr]
  #   end
  #   assert_response :success
  # end

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
end
