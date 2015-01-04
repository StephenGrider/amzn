class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
      t.timestamps null: false
      t.references :item, index: true
      t.references :user, index: true
    end
  end
end
