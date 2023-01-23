class CartItem < ApplicationRecord
  
  belongs_to :customer
  belongs_to :item
  
  validates :item_id, :quantity, presence: true
  validates :quantity, numericality:{ only_integer: true }
  # numericality: {only_integer: true}=>整数のみ許可

  # 小計を求めるメソッド
  def subtotal
    item.with_tax_price * quantity
  end
  
end
