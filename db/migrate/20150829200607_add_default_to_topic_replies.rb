class AddDefaultToTopicReplies < ActiveRecord::Migration
  def change
    change_column_default :topics, :replies, 0
  end
end
