require 'test_helper'

class CatTest < ActiveSupport::TestCase
  def setup
    @cat = cats(:one)
  end

  test "fixtures are valid" do
    assert @cat.valid?
  end

  test "age must be a number" do
    @cat.age = "one"
    refute @cat.valid?
  end
  
end
