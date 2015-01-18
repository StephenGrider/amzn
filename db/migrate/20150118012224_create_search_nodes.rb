class CreateSearchNodes < ActiveRecord::Migration
  def change
    create_table :search_nodes do |t|
      t.boolean :enabled
      t.string :category
      t.string :parent_category
      t.integer :amazon_id
      
      t.timestamps null: false
    end
  end
end
