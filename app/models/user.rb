class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  has_many :line_items
  has_many :items, :through => :line_items
  
  def self.authenticate(guid)
    User.find_or_create_by(guid: guid) do |user|
      user.email = guid
    end
  end
end
