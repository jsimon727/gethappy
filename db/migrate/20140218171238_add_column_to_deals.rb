class AddColumnToDeals < ActiveRecord::Migration
  def change
    change_table(:deals) do |t|
      t.references :user
    end
  end
end
