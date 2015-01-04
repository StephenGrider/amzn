class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :description
      t.string :price
      t.string :image_url
      t.string :url

      t.timestamps null: false
    end
  end
end
