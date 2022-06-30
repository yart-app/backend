# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.find_or_initialize_by(username: 'john_doe', name: "John Doe", email: "admin@yart.app")
user.password = "123456"
user.save!

titles = [
  "Consequatur officiis aut amet nihil consequatur mollitia ut. Nesciunt officiis rerum autem. Ea odio dolor eum.",
  "Magni error numquam laudantium. Repellat est ea vel corrupti corrupti ab. Suscipit ut in nemo dolorem cupiditate eum velit. Ad temporibus nulla quidem aut velit animi. Excepturi eius earum quae nobis eum. Est voluptatibus neque possimus itaque et ut.",
  "Iste et distinctio et reiciendis voluptates voluptatem. Velit rerum est ex iste accusantium tempore unde. Ullam sint dignissimos incidunt similique nihil quidem alias dignissimos. Quas cum et enim ipsum illo quos consequuntur eos.",
  "Maiores commodi nihil explicabo sapiente voluptatem ea aut voluptatem. Laboriosam itaque a aperiam. Fuga dolor voluptatem sit ut. Sed eveniet fugit enim minus. Veritatis aspernatur ut ipsam. Voluptate deserunt provident optio dolore porro rerum delectus.",
  "Sapiente est suscipit ut. Molestias sit aut et quisquam similique et voluptas possimus. Facilis quia fugiat porro possimus et odio. Voluptatem laboriosam esse a ut quia. Qui qui inventore nostrum eos expedita beatae quibusdam."
]

images = [
  "https://images.unsplash.com/photo-1571729024267-e0120826dfe6?fit=crop&w=456&h=570",
  "https://images.unsplash.com/photo-1585660559368-061abdc2dda2?fit=crop&w=456&h=570",
  "https://images.unsplash.com/photo-1631541909061-71e349d1f203?fit=crop&w=456&h=570",
  "https://images.unsplash.com/photo-1601379327928-bedfaf9da2d0?fit=crop&w=456&h=570",
  "https://images.unsplash.com/photo-1581497396202-5645e76a3a8e?fit=crop&w=456&h=570",
]

(0..4).each do |index|
  post = Post.custom_create(user: user, data: {"text" => titles[index]})
  post.image.attach(io: open(images[index])  , filename: "#{index}.jpg")
  # post.image.attach(io: File.open(Rails.root.join("db/images/#{index}.jpg"))  , filename: "foo.png")
  post.save!
end
