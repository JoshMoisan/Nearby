class Review < ApplicationRecord
  belongs_to :booking

  validates :rating, :comment, presence: true
  validates :comment, length: { minimum: 15 }
end
