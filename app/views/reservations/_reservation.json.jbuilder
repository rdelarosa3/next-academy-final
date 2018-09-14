json.extract! reservation, :id, :user_id, :service_id, :reservation_date, :reservation_time, :notes, :created_at, :updated_at
json.url reservation_url(reservation, format: :json)
