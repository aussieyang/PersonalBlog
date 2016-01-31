class User < ActiveRecord::Base
  has_secure_password # gives 2 new methods for user object
  # 1. password
  # 2. authenticate
  has_many :posts

  validates :email, presence: true
  validates :email, length: { minimum: 2 }

  validates :password_digest, presence: true

  validates :name, presence: true
  validates :name, length: { minimum: 2 }

  validates :about, presence: true
  validates :about, length: { minimum: 50 }
end
