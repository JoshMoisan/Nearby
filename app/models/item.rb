class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :photo
  has_many :bookings
  has_many :reviews, through: :bookings

  # Pending validation when implemented: item_picture
  CATEGORIES = %w[Tools Electronics Gaming Arts\ &\ Crafts Garden Decoration Sports Camping Other]
  CONDITION = %w[New Good Fair Poor]
  validates :name, :category, :condition, :description, :price, presence: true
  validates :description, length: { minimum: 15 }
  validates :category, inclusion: { in: Item::CATEGORIES }
  validates :condition, inclusion: { in: Item::CONDITION }

  def user_location
    user.address
  end

  include PgSearch::Model
  pg_search_scope :search_by, associated_against: {
                  user: :address
                  },
                  against: %i[name category description],
                  using: { tsearch: { prefix: true } }
end
