class ChangeEnvironmentColumnNameInColonies < ActiveRecord::Migration
  def change
    rename_column :colonies, :enviroment, :environment
  end
end
