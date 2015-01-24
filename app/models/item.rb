class Item < ActiveRecord::Base
  self.per_page = 20
  
  has_many :line_items
  has_many :users, :through => :line_items
  belongs_to :search_node
  
  validates :title, presence: true
  validates :image_url, presence: true
  validates :url, presence: true
  validates :brand, presence: true
  validates :price, presence: true
  validates :wishlist_url, presence: true
  validates :tell_friend_url, presence: true
  
  scope :unseen, lambda { |user|
    joins("left outer join line_items as i on items.id = i.item_id")
    .where("i.user_id is not ?", user.id)
  }
  
  scope :liked_by, lambda { |user|
    joins("left outer join line_items as i on items.id = i.item_id")
    .where("i.user_id is ?", user.id)
  }
  
  def is_liked?(user)
    user.items.include?(self)
  end
  
  def category
    search_node.category
  end
  
  def parent_category
    search_node.parent_category
  end
end
