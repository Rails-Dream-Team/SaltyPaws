require 'test_helper'

class ColonyTest < ActiveSupport::TestCase
  def setup
    @colony = colonies(:one)
    @user = users(:admin)
  end

  test 'fixtures are valid' do
    assert @colony.valid?
  end

  test 'invalid without a name' do
    @colony.name = ""
    refute @colony.valid?
  end

  test 'invalid without street_address' do
    @colony.street_address = ""
    refute @colony.valid?
  end

  test 'invalid without a city' do
    @colony.city = ""
    refute @colony.valid?
  end

  test 'invalid without state' do
    @colony.state = ""
    refute @colony.valid?
  end

  test 'pop can be blank' do
    @colony.pop = nil
    assert @colony.valid?
  end

  test 'pop has to be a integer' do
    @colony.pop = "string"
    refute @colony.valid?
  end

  test 'lat has to be a decimal' do
    @colony.lat = "string"
    refute @colony.valid?

    @colony.lat = 39.99998
    assert @colony.valid?

    @colony.lat = -39.99999
    assert @colony.valid?
  end

  test 'lng has to be a decimal' do
    @colony.lng = "string"
    refute @colony.valid?

    @colony.lng = 79.99998
    assert @colony.valid?

    @colony.lng = -79.99999
    assert @colony.valid?
  end

  test 'has many cats' do
    assert_respond_to @colony, :cats
    assert_kind_of Cat, @colony.cats.new
  end

  test 'has many users' do
    assert_respond_to @colony, :users
    assert_kind_of User, @colony.users.new
  end

  test 'can access an owner' do
    assert_respond_to @colony, :owners
    assert_equal @user, @colony.owners[0]
  end

  test 'can access multiple owners' do
    assert_respond_to @colony, :owners
    user2 = users(:volunteer)
    @colony.colony_users.create!(user: user2, owner: true)
    [@user, user2].each do |u|
      assert_includes @colony.owners, u
    end
  end

  test 'can access volunteers' do
    assert_respond_to @colony, :volunteers
    user3 = users(:basic)
    assert_includes @colony.volunteers, user3
  end
end
