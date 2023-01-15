class PreOrder < ApplicationRecord

  belongs_to :customer
  has_many :pre_order_details
  has_many :items, through: :pre_orders_details

  def subtotal
    item.with_tax_price * quantity
  end

  def with_tax_price
    (self.price * 1.10).round
  end

end
