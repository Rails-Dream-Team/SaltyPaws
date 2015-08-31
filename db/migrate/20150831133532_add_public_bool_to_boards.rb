class AddPublicBoolToBoards < ActiveRecord::Migration
  def change
    add_column :boards, :public, :boolean, default: false, null: false
  end
end
