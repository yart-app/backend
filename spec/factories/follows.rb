FactoryBot.define do
  factory :follow do
    association :follower
    association :followee
  end
end
