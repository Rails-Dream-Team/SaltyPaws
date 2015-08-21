require 'test_helper'

class OrganizationTest < ActiveSupport::TestCase
  def setup
    @organization = organizations(:one)
  end

  test 'fixtures are valid' do
    assert @organization.valid?
  end

  test 'is invalid without a name' do
    @organization.name = ''
    refute @organization.valid?
  end

  test 'assert responds to users' do
    assert_respond_to @organization, :users
    assert_instance_of User, @organization.users.new
  end
end
