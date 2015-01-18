class AddSearchnodeToLogs < ActiveRecord::Migration
  def change
    add_column :logs, :search_node_id, :integer
  end
end
