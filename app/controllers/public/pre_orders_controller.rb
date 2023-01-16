class Public::PreOrdersController < ApplicationController

  before_action :authenticate_customer!
  before_action :ensure_guest_customer

  #予約注文情報の入力画面で受取日、受取時間の選択、要望を入力できる
  def new
    @pre_order = PreOrder.new
  end

  # 予約注文情報確認画面
  def check
    # new 画面から渡ってきたデータを @pre_order に入れる
    @pre_order = PreOrder.new(pre_order_params)
    @receiving_date = params[:pre_order][:receiving_date]
    @cart_items = current_customer.cart_items.all # カートアイテムの情報を会員に確認してもらうために使用
    @pre_order.total_payment = @total_payment
    @total_payment = @cart_items.inject(0) { |sum, item| sum + item.subtotal }
    @pre_order_new = PreOrder.new
  # 請求金額を出す処理 subtotal はモデルで定義したメソッド
  end

  def over
  end

  # 予約注文を確定する
  def create # PreOrderに情報を保存
    # 渡ってきた値を @pre_order に入れる
    @pre_order = current_customer.pre_orders.new(pre_order_params)

    # "01月16日(月) => Date.parse("2023-01-16")
    @pre_order.receiving_date = Date.parse("#{Date.today.year}-#{params[:pre_order][:receiving_date].split('日')[0].gsub!(/[^\d]/, '-')}")
    @pre_order.customer_id = current_customer.id
    @pre_order.save

      @cart_items = current_customer.cart_items
      @cart_items.each do |cart_item|
        @pre_order_detail = PreOrderDetail.new
        @pre_order_detail.tax_price = cart_item.item.with_tax_price
        @pre_order_detail.quantity = cart_item.quantity
        @pre_order_detail.item_id = cart_item.item_id
        @pre_order_detail.pre_order_id = @pre_order.id
        # @pre_order_detail.status = 0 #TODO
        @pre_order_detail.save # カート情報を削除するので item との紐付けが切れる前に保存する
      end

    @cart_items.destroy_all # 会員に関連するカートのデータ(予約注文したデータ)をすべて削除(カートを空にする)
    redirect_to over_pre_orders_path

  end

  def index
    @pre_orders = current_customer.pre_orders.page(params[:page])
  end

  def show
    # checkでリロードされた時の対策
    if params[:id] == "check"
      flash[:notice] = "リロードされた為入力画面に戻りました。"
      redirect_to new_pre_order_path
      return
    end
    @pre_order = PreOrder.find(params[:id])
    @pre_order_detail = PreOrderDetail.find(params[:id])
    @pre_order_details = @pre_order.pre_order_details.all
  end

  private

  def pre_order_params
    params.require(:pre_order).permit(:customer_id, :item_id, :total_payment, :receiving_date, :receiving_time, :demand)
  end

  def ensure_guest_customer
    if current_customer.email == "guest@example.com"
      redirect_to root_path, notice: 'ゲストユーザーは予約注文情報入力画面へ遷移できません。'
    end
  end

end
