class PreOrderDetail < ApplicationRecord
  
  belongs_to :item
  belongs_to :pre_order
  
end
