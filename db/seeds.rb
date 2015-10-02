# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Role.create([{name: 'admin'}, {name: 'artist'}, {name: 'client'}])
admin = User.create(email: "admin@arters.com", name: "admin", last_name: "admin", username: "admin", password: 'aguacate', password_confirmation: 'aguacate')
admin.user_roles.first.destroy
UserRole.create(user: admin, role_id: 1)