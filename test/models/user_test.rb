require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = users(:one)
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


end
