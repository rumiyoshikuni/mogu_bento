class PreOrder < ApplicationRecord
  # 10時から20時の間で受け取り時間を選択
  START_HOUR = 10
  END_HOUR = 20

  belongs_to :customer
  has_many :pre_order_details
  has_many :items, through: :pre_orders_details
  
  # 小計を求めるメソッド
  def subtotal
    item.with_tax_price * quantity
  end
  
  # 受取り日と受取り時間のバリデーション
  validates :receiving_date, presence: true
  validates :receiving_time, presence: true
  
  validate :expiration_date_cannot_be_in_the_past
  validate :over_time
  # validate :date_current_today
  
  # モデルのステートを確認して、無効な場合にerrorsコレクションにメッセージを追加するメソッドを作成できる
  def expiration_date_cannot_be_in_the_past
      receiving_date_time= Time.zone.parse(
      "#{receiving_date.to_s} #{receiving_time.hour}:#{receiving_time.min}"
      ) 
    return if receiving_date_time >= Time.current

    errors.add(:base, "受取日、または受け取り時間の変更を行なってください。")
  end
  
  def over_time
    return if receiving_time.hour >= START_HOUR && receiving_time.hour <= END_HOUR
    
    errors.add(:base, "営業時間内の時間を指定してください。")
  end
  
  # def date_current_today
    
  #   errors.add(:receiving_date, "当日のキャンセルはできません。") if receiving_date < (Date.current + 1)
  # end

end
