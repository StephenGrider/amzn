class AddImeiToUsers < ActiveRecord::Migration
  def change
    add_column :users, :imei, :string
  end
end
