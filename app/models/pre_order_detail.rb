class PreOrderDetail < ApplicationRecord
  
  belongs_to :item
  belongs_to :order
  
end
