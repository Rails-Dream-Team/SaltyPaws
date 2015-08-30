require 'test_helper'

class TopicTest < ActiveSupport::TestCase
  def setup
    @topic = topics(:one)
  end

  test 'the fixture is valid' do
    assert @topic.valid?
  end

  test 'is invalid without a title' do
    @topic.title = nil
    refute @topic.valid?
  end

  test 'belongs to user' do
    assert_respond_to @topic, :user
    assert_equal @topic.user, users(:admin)
  end

  test 'belongs to board' do
    assert_respond_to @topic, :board
    assert_equal @topic.board, boards(:one)
  end

  test 'has many posts' do
    assert_respond_to @topic, :posts
    assert_kind_of Post, @topic.posts.new
  end
end
