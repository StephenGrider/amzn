class Log < ActiveRecord::Base

  scope :searches_for_node, lambda { |node|
    where(search_node_id: node.id).order("created_at DESC")
  }

end
