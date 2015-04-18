FactoryGirl.define do
  factory :share_queue do
    recipient_id { create(:user) }
    creator_id { create(:user) }
  end
end
