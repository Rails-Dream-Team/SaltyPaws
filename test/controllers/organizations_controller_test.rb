require 'test_helper'

class OrganizationsControllerTest < ActionController::TestCase
  def setup
    @organization = organizations(:one)
  end

  test "GET index html render" do
    get :index
    assert_equal [@organization], assigns[:organizations]
    assert_response :success
  end

  test "GET index json render" do
    get :index, format: :json
    response_item = JSON.parse(response.body)[0]
    ['id', 'name'].each do |attr|
      assert_equal @organization.send(attr), response_item[attr]
    end
    assert_response :success
  end

  test "GET new" do
    get :new
    assert_instance_of Organization, assigns(:organization)
    assert_response :success
  end

  test "POST create with valid attr and redirect html" do
    assert_difference('Organization.count', 1) do
      post :create, organization: { name: "Test"}
    end
    assert_redirected_to organization_path(assigns(:organization))
  end

  test "POST create renders new with INvalid attr html" do
    assert_no_difference('Organization.count') do
      post :create, organization: { name: "" }
    end
    assert_template :new
  end

  test "POST create with valid attr json" do
    assert_difference('Organization.count', 1) do
      post :create, format: :json, organization: { name: "Testy" }
    end
    assert_response :success
  end

  test "GET show with html" do
    get :show, id: @organization
    assert_equal @organization, assigns(:organization)
    assert_response :success
  end

  test "GET show with json" do
    get :show, id: @organization, format: :json
    response_item = JSON.parse(response.body)
    ['id', 'name'].each do |attr|
      assert_equal @organization.send(attr), response_item[attr]
    end
    assert_response :success
  end

  test "GET edit with html" do
    get :edit, id: @organization
    assert_equal @organization, assigns(:organization)
    assert_response :success
  end

  test "PATCH update with html" do
    old_name = @organization.name
    new_name = "Newest Name"
    patch :update, id: @organization, organization: { name: new_name }
    @organization.reload
    refute @organization.name == old_name
    assert_redirected_to organization_path(@organization)
  end

  test "PATCH update with json" do
    patch :update, format: :json, id: @organization, organization: { name: "Name of Newness" }
    assert_response :success
  end

  test "DELETE destroy with html" do
    assert_difference('Organization.count', -1) do
      delete :destroy, id: @organization
    end
    assert_redirected_to organizations_path
  end

  test "DELETE destroy with json" do
    assert_difference('Organization.count', -1) do
      delete :destroy, format: :json, id: @organization
    end
    assert_response :success
  end

end
