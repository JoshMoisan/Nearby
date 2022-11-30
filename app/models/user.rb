class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_one_attached :photo
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # Pending validations on pictures (id, profile)
  validates :email, :first_name, :last_name, :username, :address
  validates :username, uniqueness: true
end
