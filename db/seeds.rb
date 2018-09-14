# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
service_type = {}
types = ['Hair','Color','Waxing']
ActiveRecord::Base.transaction do
	types.length.times do
	service_type["name"] = types.pop
	ServiceType.create(service_type)
	end
end

service = {}
service_names = ["Up-Do","Haircut - Short","Haircut - Long","Haircut - Medium","Kids - Haircut","Kids - Wash & Dry","Shampoo & Blow-Dry","Shampoo, Blow-Dry & Style"]
ActiveRecord::Base.transaction do
	
	service_names.length.times do
		service["service_type"] = ServiceType.find(3)
		service["name"] = service_names.pop
		# service["description"] = Faker::Hipster.sentence
		service["price"] = rand(7..50)
		service["length"] = [15,30,60].sample

		Service.create(service)
	end
end


service = {}
service_names = ["Color Retouch","Color Retouch & Haircut","Highlights - Full set","Highlights - Partial","Highlights - Haircut"]
ActiveRecord::Base.transaction do
	
	service_names.length.times do
		service["service_type"] = ServiceType.find(2)
		service["name"] = service_names.pop
		# service["description"] = Faker::Hipster.sentence
		service["price"] = rand(55..130)
		service["length"] = [60,90,120].sample

		Service.create(service)
	end
end

service = {}
# service_names = ["Color Retouch","Color Retouch & Haircut","Highlights - Full set","Highlights - Partial","Highlights - Haircut"]
service_names = ["Eybrow Maintenance","Eybrow Shaping","Eyebrow Wax","Hairline Removal","Lip Wax","Leg Wax -Full","Leg Wax -Half","Underarm Wax","Back Wax","Arm Wax"]
ActiveRecord::Base.transaction do
	
	service_names.length.times do
		service["service_type"] = ServiceType.find(1)
		service["name"] = service_names.pop
		# service["description"] = Faker::Hipster.sentence
		service["price"] = rand(7..30)
		service["length"] = [15,30,45].sample

		Service.create(service)
	end
end
user = {}


ActiveRecord::Base.transaction do

    user['first_name'] = 'admin'
    user['last_name'] = 'admin'
    user['email'] = "admin@admin.com"
    user['role'] = 1
    user['birthday'] = Date.today
    user['password'] = 'admin'
    User.create(user)

end 

business = {}


ActiveRecord::Base.transaction do
      business['name'] = "Visible Elegance Hair Salon"
      business['street'] = "115 McCauley Ave"
      business['city'] = "San Antonio"
      business['state'] = "TX"
      business['country'] = "USA"
      business['phone'] = "+1 (210) 924-5700"
      business['zipcode'] = 78211
      business['email'] = "info@visible-elegance.com"
      business['operator'] = "Sandy"
      Business.create(business)
end


# avatar_array = ["https://randomuser.me/api/portraits/men/31.jpg","https://randomuser.me/api/portraits/men/64.jpg","https://randomuser.me/api/portraits/women/90.jpg","https://randomuser.me/api/portraits/women/62.jpg","https://randomuser.me/api/portraits/women/49.jpg"]
# User.all.each do |person|
#   person.remote_avatar_url = avatar_array.shuffle.sample
#   person.save
# end


# temp_array = ["https://images.unsplash.com/photo-1518481852452-9415b262eba4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=682a7e2a70ae366b3610b014f5bb5a97&auto=format&fit=crop&w=1950&q=80","https://images.unsplash.com/photo-1513694203232-719a280e022f?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=ee7b83f80f90879486ced1b45501ce21&auto=format&fit=crop&w=1949&q=80","https://images.unsplash.com/photo-1499955085172-a104c9463ece?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=1c30274d56662166fdafd604140d2df4&auto=format&fit=crop&w=1950&q=80","https://images.unsplash.com/photo-1484154218962-a197022b5858?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ba2b9dcc1af593a7d93ed9b4ed952ac&auto=format&fit=crop&w=1953&q=80","https://images.unsplash.com/photo-1488805990569-3c9e1d76d51c?ixlib=rb-0.3.5&s=2b1e8a77c89e531d8a93db3995a54bc8&auto=format&fit=crop&w=1950&q=80","https://images.unsplash.com/photo-1472504929007-6d7cd0ef7d50?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a08e9460cac871fd84d91b27214d5e35&auto=format&fit=crop&w=1950&q=80"]
# images_array = []

# 2.times do
#   Listing.all.each do |place|
#   images_array << temp_array.shuffle.sample
#   images_array << temp_array.shuffle.sample
#   place.remote_images_urls = images_array
#   place.save
#   images_array = []
#   end
# end