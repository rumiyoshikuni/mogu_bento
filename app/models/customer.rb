class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, presence: true
  validates :encrypted_password, presence: true
  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_name_kana, presence: true
  validates :first_name_kana, presence: true
  validates :tel_number, presence: true, numericality: {only_integer: true}, length: { in: 10..11 }
  # numericality: {only_integer: true}=>整数のみ許可、length: { in: 10..11 }=>文字数制限(10〜11桁)

  has_many :pre_orders, dependent: :destroy
  has_many :cart_items

  def update_without_current_password(params, *options)
    params.delete(:current_password)
  # update_without_current_passwordメソッド：パスワード抜きで更新できるようにする

    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end
    # params[:password]に紐づく要素が存在しなかった場合は、:passwordと:password_confirmationをキーに持つ要素を取り除く

    result = update_attributes(params, *options)
    clean_up_passwords
    result
  end

  def active_for_authentication?
    super && (is_deleted == false)
  end

  def self.guest
    #find_or_create_by:データの検索と作成を自動的に判断して処理を行う、Railsのメソッド
    find_or_create_by!(email: 'guest@example.com') do |customer|
      customer.password = SecureRandom.urlsafe_base64
      customer.last_name = 'guestcustomer'
      customer.first_name = 'guestcustomer'
      customer.last_name_kana = 'guestcustomer'
      customer.first_name_kana = 'guestcustomer'
      customer.tel_number = 'guestcustomer'
    end
  end

end
