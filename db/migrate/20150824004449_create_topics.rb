class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :title, null: false
      t.integer :user_id, null: false

      t.timestamps null: false
    end

    add_index :topics, :title
  end
end
