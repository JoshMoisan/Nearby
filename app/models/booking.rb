class Booking < ApplicationRecord
  belongs_to :item
  belongs_to :user
  has_many :reviews

  enum status: %i[pending rejected confirmed]
end
