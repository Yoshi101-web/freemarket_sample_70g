class Location < ApplicationRecord
  belongs_to :user, optional: true
  validates :family_name, :first_name, :family_name_kana, :first_name_kana, :postal_code, :prefecture, :city, :phone_name, presence: true
end