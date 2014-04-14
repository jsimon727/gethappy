class CreateFavoriteBars < ActiveRecord::Migration
  def change
    create_table :favorite_bars do |t|
      t.references :user
      t.references :bar
    end
  end
end
