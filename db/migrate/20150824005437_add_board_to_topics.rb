class AddBoardToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :board_id, :integer, null: false
  end
end
