# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create username: 'jtompkins8', user_type: 'admin'
User.create username: 'rsherman7', user_type: 'professor'
User.create username: 'plester3', user_type: 'professor'
User.create username: 'kuser', user_type: 'student'
Course.create title: 'CS 2110', start: '9:05', end: '10:55', user_id: User.where(username: 'rsherman7').first.id
Course.create title: 'CS 4240', start: '14:05', end: '14:55', user_id: User.where(username: 'plester3').first.id
