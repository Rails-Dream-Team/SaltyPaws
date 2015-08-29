class AddReplyCountToTopicsTable < ActiveRecord::Migration
  def change
    add_column :topics, :replies, :integer
    add_index :topics, :replies
  end
end
