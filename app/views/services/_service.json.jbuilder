json.extract! service, :id, :type, :name, :description, :price, :length, :created_at, :updated_at
json.url service_url(service, format: :json)
