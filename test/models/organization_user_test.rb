require 'test_helper'

class OrganizationUserTest < ActiveSupport::TestCase
  def setup
    @organization_user = organization_users(:one)
  end

  test "fixture is valid" do
    assert @organization_user.valid?
  end

  test "assert belongs to user" do
    assert_respond_to @organization_user, :user
    @organization_user.user = users(:one)
    assert_instance_of User, @organization_user.user
  end

  test "assert belongs to organization" do
    assert_respond_to @organization_user, :organization
    @organization_user.organization = organizations(:one)
    assert_instance_of Organization, @organization_user.organization
  end
  
end
