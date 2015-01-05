class LineItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :item
  
  validates :user_id, :uniqueness => { :scope => :item_id }
end
