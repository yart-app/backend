FactoryBot.define do
  factory :comment do
    association :user
    text { Faker::HarryPotter.quote }

    factory :comment_on_post do
      association :post
    end

    factory :comment_on_project do
      association :project
    end
  end
end
