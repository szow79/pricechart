class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name, :description, :url, null: false
      t.integer :user_id
    end
  end
end
