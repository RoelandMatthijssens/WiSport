require 'faker'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user1 = User.create(username: "rik", email: "rik@default.com", password: "roeland1")

info = Information.create(media: "text", description: Faker::Lorem.paragraph)

ex1 = Exercise.create(name: "Run Elsene Vijvers", title: "Run Elsene Vijvers", typee: "running", information: info)

TrainingsSession.create(exercises: [ex1])