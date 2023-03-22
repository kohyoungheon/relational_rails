class CreateGarages < ActiveRecord::Migration[5.2]
  def change
    create_table :garages do |t|
      t.boolean :indoor
      t.integer :slots
      t.string :city
      t.string :zipcode
      t.string :name

      t.timestamps
    end
  end
end
