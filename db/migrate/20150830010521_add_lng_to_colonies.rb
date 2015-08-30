class AddLngToColonies < ActiveRecord::Migration
  def change
    add_column :colonies, :lng, :decimal, {:precision=>10, :scale=>6}
  end
end
