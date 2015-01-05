class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
      t.timestamps null: false
      t.integer :item_id, index: true
      t.integer :user_id, index: true
    end
  end
end
