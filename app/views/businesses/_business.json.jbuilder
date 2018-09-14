json.extract! business, :id, :name, :street, :city, :state, :country, :phone, :zipcode, :email, :facebook, :instagram, :youtube, :twitter, :logo, :operator, :created_at, :updated_at
json.url business_url(business, format: :json)
