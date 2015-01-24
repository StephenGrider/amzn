class AddLikeToLineItems < ActiveRecord::Migration
  def change
    add_column :line_items, :liked, :boolean
  end
end
