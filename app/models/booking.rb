class Booking < ApplicationRecord
  belongs_to :item
  belongs_to :user

  enum status: %i[pending rejected confirmed]
end
