class AddAttrsToItems < ActiveRecord::Migration
  def change
    add_column :items, :brand, :string
  end
end
