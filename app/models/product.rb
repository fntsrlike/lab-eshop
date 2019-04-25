class Product < ApplicationRecord
  acts_as_paranoid

  belongs_to :shop
  has_many :ordered_items
  has_many :orders, through: :ordered_items

  validates_presence_of :name, :price
  validates_format_of :image_url, allow_blank: true, with: URI::regexp(%w(http https))

  after_save :update_order_total_cost!

  private
  def update_order_total_cost!
    orders.without_deal.all do |order|
      order.caculate_total_cost!
    end
  end
end
