class CreateReviewables < ActiveRecord::Migration
  def change
    create_table :reviewables do |t|
      t.timestamps null: false
      t.integer :item_id
      t.integer :line_item_id
      t.integer :share_queue_id
    end
  end
end
