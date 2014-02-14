class ChangeAttributeType < ActiveRecord::Migration
   def change
    change_table(:locations) do |t|
      t.remove :zip_code
      t.string :zip_code
    end
  end
end
