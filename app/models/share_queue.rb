class ShareQueue < ActiveRecord::Base
  has_many :line_items

  validates :recipient_id, presence: true
  validates :creator_id, presence: true

  scope :created_by, lambda { |user|
    where(creator_id: user.id)
  }

  scope :received_by, lambda { |user|
    where(recipient_id: user.id)
  }

  def complete?
    line_items.where(liked: nil).empty?
  end
end
