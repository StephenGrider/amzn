class AddGuidToUsers < ActiveRecord::Migration
  def change
    add_column :users, :guid, :string
  end
end
