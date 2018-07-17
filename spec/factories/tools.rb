FactoryBot.define do
  factory :tool do
    name { Faker::Science.element }
    url { Faker::Internet.url("example.com") }
    association :user

    factory :tool_with_image do
      after(:build) do |tool|
        image_path = Rails.root.join("spec", "factories", "images", "cat-1.jpg")
        file = File.open(image_path)
        tool.images.attach(
          io: file,
          filename: "cat-1.jpg",
          content_type: "image/jpeg",
        )
      end
    end
  end
end
