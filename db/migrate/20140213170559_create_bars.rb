class CreateBars < ActiveRecord::Migration
  def change
    create_table :bars do |t|
      t.string :name
      t.string :operation_hour
      t.text :review
      t.string :contact
      t.references :location
    end
  end
end
