class CreateCats < ActiveRecord::Migration
  def change
    create_table :cats do |t|
      t.string  :name
      t.text    :description
      t.string  :sex
      t.integer :age
      t.date    :date_trapped
      t.boolean :altered
      t.boolean :eartipped
      t.string  :rabies_tag
      t.string  :distemper
      t.string  :microchip
      t.string  :photo
      t.integer :colony_id

      t.timestamps null: false
    end
    add_index :cats, :colony_id, unique: true
  end
end
