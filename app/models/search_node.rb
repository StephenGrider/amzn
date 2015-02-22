class SearchNode < ActiveRecord::Base
  scope :by_vendor, -> vendor { where(vendor: vendor) }
end
