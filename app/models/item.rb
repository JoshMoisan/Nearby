class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :photo

  # Pending validation when implemented: item_picture
  CATEGORIES = %w[Tools Electronics Gaming Arts\ &\ Crafts Garden Decoration Sports Camping Other]
  CONDITION = %w[New Good Fair Poor]
  validates :name, :category, :condition, :description, :photo, :price, presence: true
  validates :description, length: { minimum: 15 }
  validates :category, inclusion: { in: CATEGORIES }
  validates :condition, inclusion: { in: CONDITION }

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
