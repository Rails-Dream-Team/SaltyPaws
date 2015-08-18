require 'test_helper'

class ColonyUserTest < ActiveSupport::TestCase
  def setup
    @colony_user = colony_users(:one)
  end

  test "fixture is valid" do
    assert @colony_user.valid?
  end

  test "assert belongs to user" do
    assert_respond_to @colony_user, :user
    @colony_user.user = users(:one)
    assert_instance_of User, @colony_user.user
  end

  test "assert belongs to colony" do
    assert_respond_to @colony_user, :colony
    @colony_user.colony = colonies(:one)
    assert_instance_of Colony, @colony_user.colony
  end
  

end
