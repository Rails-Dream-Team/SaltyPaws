require 'test_helper'

class BoardTest < ActiveSupport::TestCase
  def setup
    @private_board = boards(:one)
    @public_board = boards(:two)
  end

  test 'the fixtures are valid' do
    assert @private_board.valid?
    assert @public_board.valid?
  end

  test 'is invalid without a title' do
    @public_board.title = nil
    refute @public_board.valid?
  end

  test 'has many topics' do
    assert_respond_to @public_board, :topics
    assert_kind_of Topic, @public_board.topics.new
  end

  test 'default is private' do
    new_board = Board.create!(title: 'fake new board')
    refute new_board.public
  end
end
