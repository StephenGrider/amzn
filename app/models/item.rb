class Item < ActiveRecord::Base
  has_many :line_items
  has_many :users, :through => :line_items
end
