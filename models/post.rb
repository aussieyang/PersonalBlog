class Post < ActiveRecord::Base
  belongs_to :user

  validates :heading, presence: true
  validates :heading, length: { minimum: 2 }
  validates :post, presence: true
  validates :post, length: { minimum: 50 }
end
