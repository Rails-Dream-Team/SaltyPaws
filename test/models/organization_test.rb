require 'test_helper'

class OrganizationTest < ActiveSupport::TestCase
  def setup
    @organization = organizations(:one)
  end

  test 'fixtures are valid' do
    assert @organization.valid?
  end

  test 'organization INvalid without a name' do
    @organization.name = ''
    refute @organization.valid?
  end
end
