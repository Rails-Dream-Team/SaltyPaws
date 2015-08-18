require 'test_helper'

class ColonyTest < ActiveSupport::TestCase
  def setup
    @colony = colonies(:one)
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

  

end
