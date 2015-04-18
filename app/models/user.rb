class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :line_items
  has_many :items, :through => :line_items

  def self.authenticate(guid)
    User.find_or_create_by(guid: guid) do |user|
      user.email = guid
    end
  end

  def admin?
    admin
  end
end
