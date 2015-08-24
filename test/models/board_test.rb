require 'test_helper'

class BoardTest < ActiveSupport::TestCase
  def setup
    @board = boards(:one)
  end

  test 'the fixture is valid' do
    assert @board.valid?
  end

  test 'is invalid without a title' do
    @board.title = nil
    refute @board.valid?
  end

  test 'has many topics' do
    assert_respond_to @board, :topics
    assert_kind_of Topic, @board.topics.new
  end
end
