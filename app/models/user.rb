class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :photo
  has_many :bookings
  has_many :items
  has_many :rented_items, through: :bookings, source: :item
  # Pending validations on pictures (id, profile)
  validates :email, :first_name, :last_name, :username, :address, presence: true
  validates :username, uniqueness: true
end
