class ShareQueue < ActiveRecord::Base
  has_many :line_items

  validates :recipient_id, presence: true
  validates :creator_id, presence: true

  scope :created_by, lambda { |user|
    joins("inner join users on share_queues.creator_id = users.id")
  }

  scope :received_by, lambda { |user|
    joins("inner join users on share_queues.recipient_id = users.id")
  }

  def complete?
    line_items.where("liked IS ?", nil).empty?
  end
end
