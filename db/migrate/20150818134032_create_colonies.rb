class CreateColonies < ActiveRecord::Migration
  def change
    create_table :colonies do |t|
      t.string :name, null: false
      t.string :photo
      t.string :street_address, null:false
      t.string :city, null: false
      t.string :state, null: false
      t.string :zip_code
      t.string :enviroment
      t.integer :pop
      t.string :vet

      t.timestamps null: false
    end

  end
end
