class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # dependent: :destroy =>「親モデルを削除する際に、その親モデルに紐づく「子モデル」も一緒に削除できる」
  has_many :pre_orders, dependent: :destroy
  has_many :cart_items
  
   # numericality: {only_integer: true}=>整数のみ許可、length: { in: 10..11 }=>文字数制限(10〜11桁)
  validates :email, presence: true
  validates :encrypted_password, presence: true
  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_name_kana, presence: true
  validates :first_name_kana, presence: true
  validates :tel_number, presence: true
  
  # update_without_current_password：パスワード抜きで更新できるようにするメソッド
  def update_without_current_password(params, *options)
    params.delete(:current_password)

    # params[:password]に紐づく要素が存在しなかった場合は、: passwordと:password_confirmationをキーに持つ要素を取り除く
    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end
    
    # update_attributes: Hashを引数に渡してデータベースのレコードを複数同時に更新することができるメソッド
    result = update_attributes(params, *options)
    clean_up_passwords
    result
  end
  
  # そのモデルのis_deletedカラムがfalseを返す（= 削除された会員でない）と、このメソッドはtrueと評価され、ログインすることができる。
  def active_for_authentication?
    super && (is_deleted == false)
  end

  #find_or_create_by:データの検索と作成を自動的に判断して処理を行う、Railsのメソッド
  def self.guest
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
