# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Admin.create!(email: 'admin@example.com' , password: 'password' )

(1..10).each do |i|
  User.create!(
    name: Faker::Name.name,
    email: "user#{i}@example.com",
    password: "password"
  )
end

if Rails.evn.development?
  users = User.all.limit(3)
  
  users.each_with_index do |user, n|
    3.downto(0) do |i|
      user.posts.create!(
        title: Faker::Lorem.word,
        body: Faker::Lorem.sentence,
        date: Time.current.ago((n + i * 2).day)
      )
    end
  end
  
  posts = Post.all
  
  User.all.sample(6).each do |user|
    user.comments.create!(
      comment: Faker::Lorem.sentence,
      post_id: posts.sample.id
    )
  end
end
