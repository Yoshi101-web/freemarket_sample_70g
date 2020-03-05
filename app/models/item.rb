class Item < ApplicationRecord
  has_many :comments
  has_many :images
  belongs_to :user
  belongs_to :category
  belongs_to :brand
end