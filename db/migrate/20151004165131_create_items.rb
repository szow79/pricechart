class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name, :url, null: false
      t.text :description, null: false
      t.integer :user_id
    end
  end
end
