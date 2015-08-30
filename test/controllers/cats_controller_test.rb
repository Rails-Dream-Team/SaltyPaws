require 'test_helper'

class CatsControllerTest < ActionController::TestCase
  def setup
    @cat = cats(:one)
    @user = users(:admin)
    sign_in @user
  end

  test "GET index html render" do
    get :index
    assert_equal [@cat], assigns[:cats]
    assert_response :success
  end

  test "GET index json render" do
    get :index, format: :json
    response_item = JSON.parse(response.body)[0]
    ['id', 'name'].each do |attr|
      assert_equal @cat.send(attr), response_item[attr]
    end
    assert_response :success
  end

  test "GET new" do
    get :new
    assert_instance_of Cat, assigns(:cat)
    assert_response :success
  end

  test "POST create with valid attr and redirect html" do
    assert_difference('Cat.count', 1) do
      post :create, cat: { name: "Test"}
    end
    assert_redirected_to cats_path(assigns(:cat))
  end

  test "POST create with valid attr json" do
    assert_difference('Cat.count', 1) do
      post :create, format: :json, cat: { name: "Testy" }
    end
    assert_response :success
  end

  test "GET show with html" do
    get :show, id: @cat
    assert_equal @cat, assigns(:cat)
    assert_response :success
  end

  test "GET show with json" do
    get :show, id: @cat, format: :json
    response_item = JSON.parse(response.body)
    ['id', 'name'].each do |attr|
      assert_equal @cat.send(attr), response_item[attr]
    end
    assert_response :success
  end

  test "GET edit with html" do
    get :edit, id: @cat
    assert_equal @cat, assigns(:cat)
    assert_response :success
  end

  test "PATCH update with html" do
    old_name = @cat.name
    new_name = "Newest Name"
    patch :update, id: @cat, cat: { name: new_name }
    @cat.reload
    refute @cat.name == old_name
    assert_redirected_to cats_path(@cat)
  end

  test "PATCH update with json" do
    patch :update, format: :json, id: @cat, cat: { name: "Name of Newness" }
    assert_response :success
  end

  test "DELETE destroy with html" do
    assert_difference('Cat.count', -1) do
      delete :destroy, id: @cat
    end
    assert_redirected_to cats_path
  end

  test "DELETE destroy with json" do
    assert_difference('Cat.count', -1) do
      delete :destroy, format: :json, id: @cat
    end
    assert_response :success
  end

end
