FactoryBot.define do
  factory :post do
    text { Faker::OnePiece.quote }
    auto_generated false
    association :project
    association :user

    factory :post_with_image do
      after(:build) do |post|
        image_path = Rails.root.join("spec", "factories", "images", "cat-1.jpg")
        file = File.open(image_path)
        post.image.attach(
          io: file,
          filename: "cat-1.jpg",
          content_type: "image/jpeg",
        )
      end
    end
  end
end
