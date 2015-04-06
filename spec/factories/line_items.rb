FactoryGirl.define do
  factory :line_item do |f|
    user
    item
    liked true
  end
end
