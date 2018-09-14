module ApplicationHelper
	def black_list
		controller_name == "sessions" || controller_name == "users" && action_name == "new" || controller_name == "reservations" && action_name == 'new' || controller_name == "service_types"
	end
end
