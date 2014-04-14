class AddColumnToBars < ActiveRecord::Migration
    def change
      change_table(:bars) do |t|
      t.string :address
      t.string :photo_url
    end
  end
end
