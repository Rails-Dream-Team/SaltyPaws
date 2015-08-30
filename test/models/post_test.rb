require 'test_helper'

class PostTest < ActiveSupport::TestCase
  def setup
    @post = posts(:one)
  end

  test 'the fixture is valid' do
    assert @post.valid?
  end

  test 'is invalid without content' do
    @post.content = nil
    refute @post.valid?
  end

  test 'belongs to user' do
    assert_respond_to @post, :user
    assert_equal @post.user, users(:admin)
  end

  test 'belongs to topic' do
    assert_respond_to @post, :topic
    assert_equal @post.topic, topics(:one)
  end
end
