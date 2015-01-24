FactoryGirl.define do
  factory :item do
    description { Faker::Lorem.sentence }
    price { Faker::Number.number(2) }
    image_url { Faker::Internet.url }
    url { Faker::Internet.url }
    title { Faker::Lorem.sentence }
    brand { Faker::Lorem.sentence }
    wishlist_url { Faker::Internet.url }
    tell_friend_url { Faker::Internet.url }
  end
end
