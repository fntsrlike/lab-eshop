class Product < ApplicationRecord
  belongs_to :shop
  has_many :ordered_items
  has_many :orders, through: :ordered_items

  validates_presence_of :name, :price
  validates_format_of :image_url, allow_blank: true, with: URI::regexp(%w(http https))
end
