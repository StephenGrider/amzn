class AddAsinToItems < ActiveRecord::Migration
  def change
    add_column :items, :asin, :string
  end
end
