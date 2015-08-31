require 'test_helper'

class ColoniesControllerTest < ActionController::TestCase
  def setup
    @colony = colonies(:one)
    @admin = users(:admin)
    @volunteer = users(:volunteer)
    @basic = users(:basic)
    @attributes = ['id', 'name', 'photo', 'street_address', 'city', 'state',
                   'zip_code', 'environment', 'pop', 'vet']
  end

  class ColoniesWhenAdmin < ColoniesControllerTest
    def setup
      super
      sign_in @admin
    end

    test "html GETs index" do
      get :index
      assert_equal [@colony], assigns[:colonies]
      assert_response :success
    end

    test "json GETs index" do
      get :index, format: :json
      response_item = JSON.parse(response.body)[0]
      @attributes.each do |attr|
        assert_equal @colony.send(attr), response_item[attr]
      end
      assert_response :success
    end

    test "html GETs new" do
      get :new
      assert_instance_of Colony, assigns(:colony)
      assert_template :new
    end

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

    test "html GETs edit when logged in" do
      get :edit, id: @colony
      assert_equal @colony, assigns(:colony)
      assert_template :edit
    end
  end

  class ColoniesWhenVolunteer < ColoniesControllerTest
    def setup
      super
      sign_in @volunteer
    end

    test "html GETs index" do
      get :index
      assert_equal [@colony], assigns[:colonies]
      assert_response :success
    end

    test "json GETs index" do
      get :index, format: :json
      response_item = JSON.parse(response.body)[0]
      @attributes.each do |attr|
        assert_equal @colony.send(attr), response_item[attr]
      end
      assert_response :success
    end

    test "html GETs new" do
      get :new
      assert_instance_of Colony, assigns(:colony)
      assert_template :new
    end

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

    test "html GETs edit when logged in" do
      get :edit, id: @colony
      assert_equal @colony, assigns(:colony)
      assert_template :edit
    end
  end

  class ColoniesWhenBasic < ColoniesControllerTest
    def setup
      super
      sign_in @basic
    end

    test "html GETs index" do
      get :index
      assert_equal [@colony], assigns[:colonies]
      assert_response :success
    end

    test "json GETs index" do
      get :index, format: :json
      response_item = JSON.parse(response.body)[0]
      @attributes.each do |attr|
        assert_equal @colony.send(attr), response_item[attr]
      end
      assert_response :success
    end

    test "html GETs new" do
      get :new
      assert_instance_of Colony, assigns(:colony)
      assert_template :new
    end

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

    test "html GETs edit when logged in" do
      get :edit, id: @colony
      assert_equal @colony, assigns(:colony)
      assert_template :edit
    end
  end

  class ColoniesCreate < ColoniesControllerTest
    test 'admin html creates with valid attributes and redirects' do
      sign_in @admin
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

    test 'admin json creates with valid attributes' do
      sign_in @admin
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

    test 'admin html renders new with invalid attributes' do
      sign_in @admin
      assert_no_difference('Colony.count') do
        post :create, colony: { name: "" }
      end
      assert_template :new
    end

    test 'admin json renders errors with invalid attributes' do
      sign_in @admin
      assert_no_difference('Colony.count') do
        post :create, format: :json, colony: { name: "" }
      end
      assert_response 422
    end

    test 'volunteer html creates with valid attributes and redirects' do
      sign_in @volunteer
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

    test 'volunteer json creates with valid attributes and responds successful' do
      sign_in @volunteer
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

    test 'basic html creates with valid attributes and redirects' do
      sign_in @basic
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

    test 'basic json creates with valid attributes and responds successful' do
      sign_in @basic
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
  end

  class ColoniesUpdate < ColoniesControllerTest
    test "admin html updates with valid attributes" do
      sign_in @admin
      old_name = @colony.name
      new_name = "Some new and different name"
      patch :update, id: @colony, colony: { name: new_name }
      @colony.reload
      refute @colony.name == old_name
      assert_equal new_name, @colony.name
      assert_redirected_to colony_path(@colony)
    end

    test "admin json updates with valid attributes" do
      sign_in @admin
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

    test "admin html renders edit with invalid attribute submission" do
      sign_in @admin
      old_name = @colony.name
      patch :update, id: @colony, colony: { name: '' }
      @colony.reload
      assert_equal old_name, @colony.name
      assert_template :edit
    end

    test 'admin json renders errors with invalid attributes' do
      sign_in @admin
      old_name = @colony.name
      patch :update,
            id: @colony,
            format: :json,
            colony: { name: "" }
      @colony.reload
      assert_equal old_name, @colony.name
      assert_response 422
    end

    test "volunteer html updates with valid attributes" do
      sign_in @volunteer
      old_name = @colony.name
      new_name = "Some new and different name"
      patch :update, id: @colony, colony: { name: new_name }
      @colony.reload
      refute @colony.name == old_name
      assert_equal new_name, @colony.name
      assert_redirected_to colony_path(@colony)
    end

    test "volunteer json updates with valid attributes" do
      sign_in @volunteer
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

    test "basic html updates with valid attributes" do
      sign_in @basic
      old_name = @colony.name
      new_name = "Some new and different name"
      patch :update, id: @colony, colony: { name: new_name }
      @colony.reload
      refute @colony.name == old_name
      assert_equal new_name, @colony.name
      assert_redirected_to colony_path(@colony)
    end

    test "basic json updates with valid attributes" do
      sign_in @basic
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
  end

  class ColoniesDelete < ColoniesControllerTest
    test "admin html soft deletes and redirects when logged in" do
      sign_in @admin
      old_unscoped = Colony.unscoped.count
      assert_difference('Colony.count', -1) do
        delete :destroy, id: @colony
      end
      @colony.reload
      assert_redirected_to colonies_path
      assert_equal old_unscoped, Colony.unscoped.count
      refute @colony.deleted_at.nil?
    end

    test "admin json soft deletes and responds successful when logged in" do
      sign_in @admin
      old_unscoped = Colony.unscoped.count
      assert_difference('Colony.count', -1) do
        delete :destroy, id: @colony, format: :json
      end
      @colony.reload
      assert_response :success
      assert_equal old_unscoped, Colony.unscoped.count
      refute @colony.deleted_at.nil?
    end

    test 'volunteer html does NOT delete' do
      sign_in @volunteer
      assert_no_difference('Colony.count') do
        delete :destroy, id: @colony
      end
      @colony.reload
      assert_redirected_to(request.referrer || root_path)
      assert @colony.deleted_at.nil?
    end

    test 'volunteer json does NOT delete' do
      sign_in @volunteer
      assert_no_difference('Colony.count') do
        delete :destroy, id: @colony, format: :json
      end
      @colony.reload
      assert_redirected_to(request.referrer || root_path)
      assert @colony.deleted_at.nil?
    end

    test 'basic html does NOT delete' do
      sign_in @basic
      assert_no_difference('Colony.count') do
        delete :destroy, id: @colony
      end
      @colony.reload
      assert_redirected_to(request.referrer || root_path)
      assert @colony.deleted_at.nil?
    end

    test 'basic json does NOT delete' do
      sign_in @basic
      assert_no_difference('Colony.count') do
        delete :destroy, id: @colony, format: :json
      end
      @colony.reload
      assert_redirected_to(request.referrer || root_path)
      assert @colony.deleted_at.nil?
    end
  end

  class ColoniesWhenLoggedOut < ColoniesControllerTest
    test "html get index redirects" do
      get :index
      assert_redirected_to new_user_session_path
    end

    test "json get index responds unauthorized" do
      get :index, format: :json
      assert_response :unauthorized
    end

    test "html GET new redirects" do
      get :new
      assert_redirected_to new_user_session_path
    end

    test 'html post create redirects' do
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

    test 'json post create responds with unauthorized' do
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

    test "html GET show redirects" do
      get :show, id: @colony
      assert_redirected_to new_user_session_path
    end

    test "json GET show responds with unauthorized" do
      get :show, id: @colony, format: :json
      assert_response :unauthorized
    end

    test "html GET edit redirects to login when logged out" do
      get :edit, id: @colony
      assert_redirected_to new_user_session_path
    end

    test 'html redirects to login when logged out' do
      old_name = @colony.name
      patch :update,
            id: @colony,
            colony: { name: "I'm a valid name!" }
      @colony.reload
      assert_equal old_name, @colony.name
      assert_redirected_to new_user_session_path
    end

    test 'json responds with unauthorized when logged out' do
      old_name = @colony.name
      patch :update,
            id: @colony,
            format: :json,
            colony: { name: "I'm a valid name!" }
      @colony.reload
      assert_equal old_name, @colony.name
      assert_response :unauthorized
    end

    test 'html redirects when user logged out' do
      assert_no_difference('Colony.count') do
        delete :destroy, id: @colony
      end
      @colony.reload
      assert_redirected_to new_user_session_path
      assert @colony.deleted_at.nil?
    end

    test 'json responds unauthorized when user logged out' do
      assert_no_difference('Colony.count') do
        delete :destroy, id: @colony, format: :json
      end
      @colony.reload
      assert_response :unauthorized
      assert @colony.deleted_at.nil?
    end
  end
end
