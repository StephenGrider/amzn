class ShareQueueId < ActiveRecord::Migration
  def change
    add_column :line_items, :share_queue_id, :integer
  end
end
