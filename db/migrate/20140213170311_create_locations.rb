class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :neighborhood
      t.string :city
      t.string :state
      t.integer :zip_code
      t.string :address
    end
  end
end
