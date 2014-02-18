# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


User.destroy_all

jessica = User.new(
  firstname: "Jessica",
  lastname: "Simon",
  email: "jsimon2789@gmail.com",
  password: "hello123",
  password_confirmation: "hello123"
)

jessica.save

