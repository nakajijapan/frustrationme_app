# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

10.times.each do |index|
  user = User.create!(
    username: "monyu_#{index}",
    password: 'monyu',
    password_confirmation: 'monyu',
    email: 'pp.kupepo.gattyanmo@gmail.com'
  )

  10.times.each do |index|
    Category.create(user_id: user.id, name: "name_#{index}")
  end
end

user = User.find_by_username('monyu_0')
6.times.each do |index|
  f = Friendship.create(user_id: user.id, following_id: index + 2)
end
