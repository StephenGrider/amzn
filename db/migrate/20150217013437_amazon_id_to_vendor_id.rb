class AmazonIdToVendorId < ActiveRecord::Migration
  def change
    rename_column :search_nodes, :amazon_id, :vendor_id
    add_column :search_nodes, :vendor, :string
  end
end
