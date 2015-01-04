class LineItem < ActiveRecord::Base
  has_many :users
  has_many :items
end
