class CreateSearchNodes < ActiveRecord::Migration
  def change
    create_table :search_nodes do |t|
      t.boolean :enabled
      t.string :name
      t.integer :identifier
      
      t.timestamps null: false
    end
  end
end
