class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.string :description
      t.string :url, null: false
      t.integer :user_id
      t.integer :data_id
      t.timestamps null: false
    end
  end
end
