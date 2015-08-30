require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = users(:admin)
  end

  test 'the fixture is valid' do
    assert @user.valid?
  end

  test 'user is invalid without email' do
    @user.email = nil
    refute @user.valid?
  end

  test 'user is invalid without first name' do
    @user.first_name = nil
    refute @user.valid?
  end

  test 'user is invalid without last name' do
    @user.last_name = nil
    refute @user.valid?
  end

  test 'user is invalid without display name' do
    @user.display_name = nil
    refute @user.valid?
  end

  test 'user age may be nil' do
    @user.age = nil
    assert @user.valid?
  end

  test 'user age cannot be a string' do
    @user.age = 'I am a string'
    refute @user.valid?
  end

  test 'user age is valid when numerical' do
    @user.age = 35
    assert @user.valid?
  end

  test 'assert responds to colonies' do
    assert_respond_to @user, :colonies
    assert_instance_of Colony, @user.colonies.new
  end

  test 'assert responds to organizations' do
    assert_respond_to @user, :organizations
    assert_instance_of Organization, @user.organizations.new
  end

  test 'assert responds to pets' do
    assert_respond_to @user, :pets
  end

  test 'assert avatar may be nil' do
    @user.avatar = nil
    assert @user.valid?
  end

end
