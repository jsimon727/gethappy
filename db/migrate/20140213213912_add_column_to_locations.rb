class AddColumnToLocations < ActiveRecord::Migration
  def change
     change_table(:locations) do |t|
      t.string :name
    end
  end
end
