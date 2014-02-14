class CreateDeals < ActiveRecord::Migration
  def change
    create_table :deals do |t|
      t.string :name
      t.string :type
      t.integer :deal_price
      t.integer :original_price
      t.text :info
      t.references :location
    end
  end
end
