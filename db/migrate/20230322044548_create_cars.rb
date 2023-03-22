class CreateCars < ActiveRecord::Migration[5.2]
  def change
    create_table :cars do |t|
      t.boolean :operational
      t.integer :miles
      t.string :color
      t.string :owner
      t.references :garage, foreign_key: true

      t.timestamps
    end
  end
end
