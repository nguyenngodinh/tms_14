# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
ActiveRecord::Base.transaction do
	User.create!(name: "Ngo Dinh Nguyen",
							email: "nguyenngodinh@outlook.com",
							password: "qweasdzxc",
							password_confirmation: "qweasdzxc",
							supervisor: true)
	99.times do |n|
	  name  = Faker::Name.name
	  email = "user-#{n+1}@fts.com"
	  password = "qweasdzxc"
	  User.create!(name:  name,
	               email: email,
	               password:              password,
	               password_confirmation: password)
	end
end

# Courses
users = User.order(:created_at).take(6)
50.times do
  name  = Faker::Name.title
  content = Faker::Lorem.sentences(5)
  Course.create!(content: content, name: name) 
end

