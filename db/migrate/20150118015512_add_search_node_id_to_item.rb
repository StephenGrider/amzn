class AddSearchNodeIdToItem < ActiveRecord::Migration
  def change
    add_column :items, :search_node_id, :integer
  end
end
