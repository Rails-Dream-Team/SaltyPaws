require 'test_helper'

class ColoniesControllerTest < ActionController::TestCase
  def setup
    @colony = colonies(:one)
    @user = users(:one)
    sign_in @user
  end

  test "GET index html" do
    get :index
    assert_equal [@colony], assigns[:colonies]
    assert_response :success
  end

  test "GET index json" do
    get :index, format: :json
    response_item = JSON.parse(response.body)[0]
    ['id', 'name', 'street_address', 'city', 'state'].each do |attr|
      assert_equal @colony.send(attr), response_item[attr]
    end
    assert_response :success
  end

  test "GET new" do
    get :new
    assert_instance_of Colony, assigns(:colony)
    assert_response :success
  end

  test 'creates with valid attributes and redirects html' do
    binding.pry
    assert_difference('Colony.count', 1) do
      post :create, colony: { name: "Test1", street_address: "123 Address", city: "testcity", state: "teststate" }
    end
    assert_redirected_to colony_path(assigns(:colony))
  end

  test 'renders new with INvalid attributes html' do
    assert_no_difference('Colony.count') do
      post :create, colony: { name: "" }
    end
    assert_template :new
  end

  test 'creates with valid attributes json' do
    assert_difference('Colony.count', 1) do
      post :create, format: :json, colony: { name: "Test1", street_address: "123 Address", city: "testcity", state: "teststate" }
    end
    assert_response :success
  end

  test 'renders errors with INvalid attributes' do
    post :create, format: :json, colony: { name: "", street_address: "123 Address", city: "testcity", state: "teststate" }
    assert_response(422)
  end

  test "show colony html" do
    get :show, id: @colony
    assert_equal @colony, assigns(:colony)
    assert_response :success
  end

  test "show colony json" do
    get :show, id: @colony, format: :json
    response_item = JSON.parse(response.body)
    ['id', 'name', 'street_address', 'city', 'state'].each do |attr|
      assert_equal @colony.send(attr), response_item[attr]
    end
    assert_response :success
  end

  test "edit colony html" do
    get :edit, id: @colony
    assert_equal @colony, assigns(:colony)
    assert_response :success
  end

  test "update colony html" do
    old_name = @colony.name
    new_name = "New_Name"
    patch :update, id: @colony, colony: { name: new_name }
    @colony.reload
    refute @colony.name == old_name
    assert_equal new_name, @colony.name
    assert_redirected_to colony_path(@colony)
  end

  test "update colony json" do
    patch :update, format: :json, id: @colony, colony: { name: 'NewName' }
    assert_response :success
  end

  test "destroy colony html" do
    assert_difference('Colony.count', -1) do
      delete :destroy, id: @colony
    end
    assert_redirected_to colonies_path
  end

  test "destroy colony with json" do
    assert_difference('Colony.count', -1) do
      delete :destroy, format: :json, id: @colony
    end
    assert_response :success
  end

end
