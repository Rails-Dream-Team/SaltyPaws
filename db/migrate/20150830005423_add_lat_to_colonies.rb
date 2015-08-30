class AddLatToColonies < ActiveRecord::Migration
  def change
    add_column :colonies, :lat, :decimal, {:precision=>10, :scale=>6}
  end
end
