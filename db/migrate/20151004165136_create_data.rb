class CreateData < ActiveRecord::Migration
  def change
    create_table :data do |t|
      t.integer null: false
      t.timestamps null: false
    end
  end
end
