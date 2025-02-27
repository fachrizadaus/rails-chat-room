class User < ApplicationRecord
  has_many :room_messages
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :rememberable, :validatable

  validates :username, uniqueness: true, presence: true
end
