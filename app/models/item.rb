class Item < ActiveRecord::Base
  has_many :line_items
  has_many :users, :through => :line_items
  
  def is_liked?(user)
    user.items.include?(self)
  end
end
