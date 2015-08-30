require 'test_helper'

class ColoniesControllerTest < ActionController::TestCase
  def setup
    @colony = colonies(:one)
    @user1 = users(:admin)
    sign_in @user1
    @attributes = ['id', 'name', 'photo', 'street_address', 'city', 'state',
                   'zip_code', 'environment', 'pop', 'vet']
  end

  class ColoniesIndex < ColoniesControllerTest
    test "html GETs when logged in" do
      get :index
      assert_equal [@colony], assigns[:colonies]
      assert_response :success
    end

    test "json GETs when logged in" do
      get :index, format: :json
      response_item = JSON.parse(response.body)[0]
      @attributes.each do |attr|
        assert_equal @colony.send(attr), response_item[attr]
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

  class ColoniesNewCreate < ColoniesControllerTest
    test "html GETs new when logged in" do
      get :new
      assert_instance_of Colony, assigns(:colony)
      assert_template :new
    end

    test "html GET redirects to login when logged out" do
      sign_out @user1
      get :new
      assert_redirected_to new_user_session_path
    end

    test 'html creates with valid attributes and redirects' do
      assert_difference('Colony.count', 1) do
        post  :create,
              colony: {
                name: "Cats! The Musical",
                street_address: "Broadway",
                city: "New York",
                state: "New York"
              }
      end
      assert_redirected_to colony_path(assigns(:colony))
    end

    test 'json creates with valid attributes json' do
      assert_difference('Colony.count', 1) do
        post  :create,
              format: :json,
              colony: {
                name: "Cats! The Musical",
                street_address: "Broadway",
                city: "New York",
                state: "New York"
              }
      end
      assert_response 201
    end

    test 'html renders new with invalid attributes' do
      assert_no_difference('Colony.count') do
        post :create, colony: { name: "" }
      end
      assert_template :new
    end

    test 'json renders errors with invalid attributes' do
      assert_no_difference('Colony.count') do
        post :create, format: :json, colony: { name: "" }
      end
      assert_response(422)
    end

    test 'html redirects to login when logged out' do
      sign_out @user1
      assert_no_difference('Colony.count') do
        post  :create,
              colony: {
                name: "Cats! The Musical",
                street_address: "Broadway",
                city: "New York",
                state: "New York"
              }
      end
      assert_redirected_to new_user_session_path
    end

    test 'json responds with unauthorized when logged out' do
      sign_out @user1
      assert_no_difference('Colony.count') do
        post  :create,
              format: :json,
              colony: {
                name: "Cats! The Musical",
                street_address: "Broadway",
                city: "New York",
                state: "New York"
              }
      end
      assert_response :unauthorized
    end
  end

  class ColoniesShow < ColoniesControllerTest
    test "html GETs show when logged in" do
      get :show, id: @colony
      assert_equal @colony, assigns(:colony)
      assert_response :success
    end

    test "json GETs show when logged in" do
      get :show, id: @colony, format: :json
      response_item = JSON.parse(response.body)
      @attributes.each do |a|
        assert_equal @colony.send(a), response_item[a]
      end
      ['lat', 'lng'].each do |a|
        assert_equal @colony[a].to_f, response_item[a].to_f
      end
      assert_response :success
    end

    test "html GET redirects to login when logged out" do
      sign_out @user1
      get :show, id: @colony
      assert_redirected_to new_user_session_path
    end

    test "json GET responds with unauthorized when logged out" do
      sign_out @user1
      get :show, id: @colony, format: :json
      assert_response :unauthorized
    end
  end

  class ColoniesEditUpdate < ColoniesControllerTest
    test "html GETs edit when logged in" do
      get :edit, id: @colony
      assert_equal @colony, assigns(:colony)
      assert_template :edit
    end

    test "html GET edit redirects to login when logged out" do
      sign_out @user1
      get :edit, id: @colony
      assert_redirected_to new_user_session_path
    end

    test "html updates with valid attributes" do
      old_name = @colony.name
      new_name = "Some new and different name"
      patch :update, id: @colony, colony: { name: new_name }
      @colony.reload
      refute @colony.name == old_name
      assert_equal new_name, @colony.name
      assert_redirected_to colony_path(@colony)
    end

    test "json updates with valid attributes" do
      old_name = @colony.name
      new_name = "Some new and different name"
      patch :update,
            id: @colony,
            format: :json,
            colony: { name: new_name }
      @colony.reload
      assert_equal new_name, @colony.name
      assert_response 202
    end

    test "html renders edit with invalid attribute submission" do
      old_name = @colony.name
      patch :update, id: @colony, colony: { name: '' }
      @colony.reload
      assert_equal old_name, @colony.name
      assert_template :edit
    end

    test 'json renders errors with invalid attributes' do
      old_name = @colony.name
      patch :update,
            id: @colony,
            format: :json,
            colony: { name: "" }
      @colony.reload
      assert_equal old_name, @colony.name
      assert_response 422
    end

    test 'html redirects to login when logged out' do
      sign_out @user1
      old_name = @colony.name
      patch :update,
            id: @colony,
            colony: { name: "I'm a valid name!" }
      @colony.reload
      assert_equal old_name, @colony.name
      assert_redirected_to new_user_session_path
    end

    test 'json responds with unauthorized when logged out' do
      sign_out @user1
      old_name = @colony.name
      patch :update,
            id: @colony,
            format: :json,
            colony: { name: "I'm a valid name!" }
      @colony.reload
      assert_equal old_name, @colony.name
      assert_response :unauthorized
    end
  end

  class ColoniesDelete < ColoniesControllerTest
    test "html soft deletes and redirects when logged in" do
      old_unscoped = Colony.unscoped.count
      assert_difference('Colony.count', -1) do
        delete :destroy, id: @colony
      end
      @colony.reload
      assert_redirected_to colonies_path
      assert_equal old_unscoped, Colony.unscoped.count
      refute @colony.deleted_at.nil?
    end

    test "json soft deletes and responds successful when logged in" do
      old_unscoped = Colony.unscoped.count
      assert_difference('Colony.count', -1) do
        delete :destroy, id: @colony, format: :json
      end
      @colony.reload
      assert_response :success
      assert_equal old_unscoped, Colony.unscoped.count
      refute @colony.deleted_at.nil?
    end

    test 'html redirects when user logged out' do
      sign_out @user1
      assert_no_difference('Colony.count') do
        delete :destroy, id: @colony
      end
      @colony.reload
      assert_redirected_to new_user_session_path
      assert @colony.deleted_at.nil?
    end

    test 'json responds unauthorized when user logged out' do
      sign_out @user1
      assert_no_difference('Colony.count') do
        delete :destroy, id: @colony, format: :json
      end
      @colony.reload
      assert_response :unauthorized
      assert @colony.deleted_at.nil?
    end
  end

end
