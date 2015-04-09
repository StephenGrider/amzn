class Log < ActiveRecord::Base

  scope :searches_for_node, lambda { |node|
    where(search_node_id: node.vendor_id).order("created_at DESC")
  }

end
