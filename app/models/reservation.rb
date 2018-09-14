class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :service
  validates :reservation_date, presence: true
  validates :reservation_time, presence: true
  validates :service, presence: true
end
