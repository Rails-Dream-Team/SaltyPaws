require 'test_helper'

class OrganizationsControllerTest < ActionController::TestCase
  def setup
    @organization = organizations(:one)
    @user1 = users(:admin)
    sign_in @user1
    @attributes = ['id', 'name', 'description', 'street_address',
                   'city', 'state', 'zip_code']
  end

  class OrgIndex < OrganizationsControllerTest
    test "html GETs when logged in" do
      get :index
      assert_equal [@organization], assigns[:organizations]
      assert_response :success
    end

    test "json GETs when logged in" do
      get :index, format: :json
      response_item = JSON.parse(response.body)[0]
      @attributes.each do |attr|
        assert_equal @organization.send(attr), response_item[attr]
      end
      assert_response :success
    end

    test "html redirects to login when logged out" do
      sign_out @user1
      get :index
      assert_redirected_to new_user_session_path
    end

    test "json responds unauthorized when logged out" do
      sign_out @user1
      get :index, format: :json
      assert_response :unauthorized
    end
  end

  class OrgNewCreate < OrganizationsControllerTest
    test "html GETs new when logged in" do
      get :new
      assert_instance_of Organization, assigns(:organization)
      assert_template :new
    end

    test "html GET redirects to login when logged out" do
      sign_out @user1
      get :new
      assert_redirected_to new_user_session_path
    end

    test "html creates with valid attr and redirect" do
      assert_difference('Organization.count', 1) do
        post :create, organization: { name: "Test"}
      end
      assert_redirected_to organization_path(assigns(:organization))
    end

    test "json creates with valid attr and responds successful" do
      assert_difference('Organization.count', 1) do
        post :create,
             format: :json,
             organization: { name: "Testy" }
      end
      assert_response 201
    end

    test "html renders new with invalid attr" do
      assert_no_difference('Organization.count') do
        post :create, organization: { name: '' }
      end
      assert_template :new
    end

    test "json renders errors with invalid attr" do
      assert_no_difference('Organization.count') do
        post :create,
             format: :json,
             organization: { name: '' }
      end
      assert_response 422
    end

    test "html redirects to login when logged out" do
      sign_out @user1
      assert_no_difference('Organization.count') do
        post :create, organization: { name: "Test"}
      end
      assert_redirected_to new_user_session_path
    end

    test "json responds with unauthorized when logged out" do
      sign_out @user1
      assert_no_difference('Organization.count') do
        post :create,
             format: :json,
             organization: { name: "Testy" }
      end
      assert_response :unauthorized
    end
  end

  class OrgShow < OrganizationsControllerTest
    test "html GETs when logged in" do
      get :show, id: @organization
      assert_equal @organization, assigns(:organization)
      assert_response :success
    end

    test "json GETs when logged in" do
      get :show, id: @organization, format: :json
      response_item = JSON.parse(response.body)
      @attributes.each do |attr|
        assert_equal @organization.send(attr), response_item[attr]
      end
      assert_response :success
    end

    test "html GET redirects to login when logged out" do
      sign_out @user1
      get :show, id: @organization
      assert_redirected_to new_user_session_path
    end

    test "json GET responds unauthorized when logged out" do
      sign_out @user1
      get :show, id: @organization, format: :json
      assert_response :unauthorized
    end
  end

  class OrgEditUpdate < OrganizationsControllerTest
    test "html GETs edit when logged in" do
      get :edit, id: @organization
      assert_equal @organization, assigns(:organization)
      assert_template :edit
    end

    test "html GET redirects to login when logged out" do
      sign_out @user1
      get :edit, id: @organization
      assert_redirected_to new_user_session_path
    end

    test "html updates with valid attributes" do
      old_name = @organization.name
      new_name = "Some new and different name"
      patch :update, id: @organization, organization: { name: new_name }
      @organization.reload
      refute @organization.name == old_name
      assert_equal new_name, @organization.name
      assert_redirected_to organization_path(@organization)
    end

    test "json updates with valid attributes" do
      old_name = @organization.name
      new_name = "Name of newness"
      patch :update,
            format: :json,
            id: @organization,
            organization: { name: new_name }
      @organization.reload
      refute @organization.name == old_name
      assert_equal new_name, @organization.name
      assert_response 202
    end

    test "html renders edit with invalid attribute submission" do
      old_name = @organization.name
      patch :update, id: @organization, organization: { name: '' }
      @organization.reload
      assert_equal old_name, @organization.name
      assert_template :edit
    end

    test "json renders errors with invalid attribute submission" do
      old_name = @organization.name
      patch :update,
            format: :json,
            id: @organization,
            organization: { name: '' }
      @organization.reload
      assert_equal old_name, @organization.name
      assert_response 422
    end

    test 'html redirects to login when logged out' do
      sign_out @user1
      old_name = @organization.name
      patch :update, id: @organization, organization: { name: 'A valid name' }
      @organization.reload
      assert_equal old_name, @organization.name
      assert_redirected_to new_user_session_path
    end

    test "json responds with unauthorized when logged out" do
      sign_out @user1
      old_name = @organization.name
      patch :update,
            format: :json,
            id: @organization,
            organization: { name: 'A valid name' }
      @organization.reload
      assert_equal old_name, @organization.name
      assert_response :unauthorized
    end
  end

  class OrgDelete < OrganizationsControllerTest
    test "html soft deletes and redirects when logged in" do
      old_unscoped = Organization.unscoped.count
      assert_difference('Organization.count', -1) do
        delete :destroy, id: @organization
      end
      @organization.reload
      assert_redirected_to organizations_path
      assert_equal old_unscoped, Organization.unscoped.count
      refute @organization.deleted_at.nil?
    end

    test "json soft deletes and responds successful when logged in" do
      old_unscoped = Organization.unscoped.count
      assert_difference('Organization.count', -1) do
        delete :destroy, id: @organization, format: :json
      end
      @organization.reload
      assert_response :success
      assert_equal old_unscoped, Organization.unscoped.count
      refute @organization.deleted_at.nil?
    end

    test 'html redirects when user logged out' do
      sign_out @user1
      assert_no_difference('Organization.count') do
        delete :destroy, id: @organization
      end
      @organization.reload
      assert_redirected_to new_user_session_path
      assert @organization.deleted_at.nil?
    end

    test 'json responds unauthorized when user logged out' do
      sign_out @user1
      assert_no_difference('Organization.count') do
        delete :destroy, id: @organization, format: :json
      end
      @organization.reload
      assert_response :unauthorized
      assert @organization.deleted_at.nil?
    end
  end
end
