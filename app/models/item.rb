class Item < ApplicationRecord
  has_many :comments
  has_many :images, dependent: :destroy
  belongs_to :user
  belongs_to :category, dependent: :destroy, optional: true
  has_many :likes, dependent: :destroy
  has_many :liking_users, through: :likes, source: :user

  def self.search(search)
    return Item.all unless search
    Item.where('item_name LIKE(?)', "%#{search}%")
  end



  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture

# allow_destroy: trueで、親(item)が削除されると紐づいているimage,category
  accepts_nested_attributes_for :images, allow_destroy: true, reject_if: :all_blank
  validates                     :images , presence: { message: "がありません" }

# 商品名、商品詳細、商品状態、配送料、配送元、配送日時、商品化価格のバリデーション
  validates :item_name, :description, :price, presence: true
  validates :category_id, presence: { message: "を選択してください" }
  validates :condition, presence: { message: "を選択してください" }
  validates :shipping_fee_payer, presence: { message: "を選択してください" } 
  validates :prefecture_id, presence: { message: "を選択してください" }
  validates :shipping_days, presence: { message: "を選択してください" }


  # 商品名40文字以内
  validates :item_name, length: {minimum: 1,maximum: 40}
  # 商品詳細1000文字以内
  validates :description, length: {minimum: 1,maximum: 1000}

  # 商品価格のバリデーション
  validates :price, presence: true, numericality: { only_integer: true,greater_than: 300, less_than: 9999999}
end
