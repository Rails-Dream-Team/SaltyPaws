class AddDeletedAtToColonies < ActiveRecord::Migration
  def change
    add_column :colonies, :deleted_at, :datetime
    add_index :colonies, :deleted_at
  end
end
