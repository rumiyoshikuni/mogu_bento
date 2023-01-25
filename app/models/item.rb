class Item < ApplicationRecord
  
  # through:「多対多」のつながりを設定
  belongs_to :genre
  has_many :cart_items
  has_many :pre_orders, through: :pre_order_details
  has_many :pre_order_details

  validates :genre_id, :name, :introduction, :calorie, :allergy, :price, :is_active, presence: true
  
  # has_one_attached :レコードとファイルの間に1対1のマッピングを設定。レコード1件ごとに1個の画像を添付できる。
  has_one_attached :image

  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end
  
  # with_tax_price: 消費税を求めるメソッド、round： 小数点切り上げ
  def with_tax_price
    (self.price * 1.10).round
  end

end
