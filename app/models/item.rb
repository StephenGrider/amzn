class Item < ActiveRecord::Base
  has_many :line_items
  has_many :users, :through => :line_items
  
  validates :title, presence: true
  validates :image_url, presence: true
  validates :url, presence: true
  validates :brand, presence: true
  validates :price, presence: true
  validates :wishlist_url, presence: true
  validates :tell_friend_url, presence: true
  
  def is_liked?(user)
    user.items.include?(self)
  end
end
