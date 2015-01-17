class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.text :json
      t.text :message
      t.text :asin
      t.integer :page_fetched
      t.integer :total_pages
      t.boolean :success
      
      t.timestamps null: false
    end
  end
end
