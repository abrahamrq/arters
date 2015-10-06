# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Role.create([{ name: 'admin' }, { name: 'artist' }, { name: 'client' }])
admin = User.create(email: 'admin@arters.com', name: 'admin', 
										last_name: 'admin', username: 'admin', password: 'aguacate',
										password_confirmation: 'aguacate')
admin.user_roles.first.destroy
UserRole.create(user: admin, role_id: 1)
artist = User.create(email: 'artist@arters.com', name: 'artist', 
										 last_name: 'artist', username: 'artist', 
										 password: 'aguacate', password_confirmation: 'aguacate')
artist_request = ArtistRequest.create(message: 'default', user_id: artist.id)
artist_request.accepted!
artist_request.authorize_user

url = 'http://www.knockssg.com/resources/img/image_not_available.png'
40.times do |number|
	price = rand(10.99...59.99).round(2)
	category = rand(0...8)
	quantity = rand(1...3)
	name = "Item#{number}"
	description = "Item#{number} description... Lorem ipsum dolor sit amet, 
								 consectetuer adipiscing elit. Aenean commodo ligula eget dolor.
								 Aenean massa. Cum sociis natoque penatibus et magnis dis 
								 parturient montes, nascetur ridiculus mus. Donec quam felis, 
								 ultricies nec, pellentesque eu, pretium quis, sem. Nulla 
								 consequat massa quis enim."
	Item.create(price: price, category: category, name: name, quantity: quantity,
							description: description, image_url: url, user_id: artist.id)
end