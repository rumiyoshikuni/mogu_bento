class Genre < ApplicationRecord
  
  has_many :items
  # uniqueness: 属性の値が一意であり重複していないことを検証
  validates :name, presence: true, uniqueness: true
  
end
