# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

UserType.create user_type: 'professor'
UserType.create user_type: 'admin'
UserType.create user_type: 'ta'
id = UserType.find_by_user_type('admin').id
User.create username: 'john', user_type_id: id
