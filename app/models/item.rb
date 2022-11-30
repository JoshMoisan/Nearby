class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :photo


  CATEGORIES = %w[ Tools Appliances ]
  # Pending validation when implemented: item_picture
  validates :name, :category, :condition, :description, :price, presence: true
  validates :category, inclusion: { CATEGORIES }
end
