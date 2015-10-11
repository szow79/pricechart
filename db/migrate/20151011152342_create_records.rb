class CreateRecords < ActiveRecord::Migration
  def change
    create_table :records do |t|
      t.integer :price, null: false
      t.integer :item_id
      t.timestamps null: false
    end
  end
end
