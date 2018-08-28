FactoryBot.define do
  factory :comment do
    association :project
    association :post
    association :user
    text "MyString"
  end
end
