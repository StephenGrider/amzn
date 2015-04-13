class CreateShareQueues < ActiveRecord::Migration
  def change
    create_table :share_queues do |t|
      t.timestamps null: false
      t.integer :creator_id
      t.integer :recipient_id
    end
  end
end
