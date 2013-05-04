# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.create!(
  username: 'monyu',
  password: 'monyu',
  password_confirmation: 'monyu',
  email: 'pp.kupepo.gattyanmo@gmail.com'
)

10.times.each do |index|
  Category.create(user_id: user.id, name: "name_#{index}")
end

