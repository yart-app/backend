FactoryBot.define do
  factory :project do
    title Faker::Book.title
    pattern_url Faker::Internet.url('example.com')
    category Project::Category::OPTIONS.sample
    status Project::Status::OPTIONS.sample
    association :user
  end
end
