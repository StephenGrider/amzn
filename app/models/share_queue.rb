class ShareQueue < ActiveRecord::Base
  has_many :line_items

  validates :recipient_id, presence: true
  validates :creator_id, presence: true

  def complete?
    
  end
end
