FactoryBot.define do
  factory :comment do
    association :user
    text { Faker::Movies::HarryPotter.quote }

    factory :comment_on_post do
      association :post
    end

    factory :comment_on_project do
      association :project
    end
  end
end
