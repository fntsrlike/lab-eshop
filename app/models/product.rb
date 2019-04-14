class Product < ApplicationRecord
  belongs_to :shop
  validates_presence_of :name, :price
  validates_format_of :url, with: URI::regexp(%w(http https))
end
