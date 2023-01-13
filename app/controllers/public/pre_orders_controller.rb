class Public::PreOrdersController < ApplicationController

  before_action :authenticate_customer!

  #予約注文情報の入力画面で受取日、受取時間の選択、要望を入力できる
  def new
    @pre_order = PreOrder.new
  end

  # 予約注文情報確認画面
  def check
    # new 画面から渡ってきたデータを @pre_order に入れる
    @pre_order = PreOrder.new(pre_order_params)
    @pre_order.total_payment = @total_payment
    @cart_items = current_customer.cart_items.all # カートアイテムの情報をユーザーに確認してもらうために使用
    @total_payment = @cart_items.inject(0) { |sum, item| sum + item.subtotal }
  # 請求金額を出す処理 subtotal はモデルで定義したメソッド
  end

  def over
  end

  # 予約注文を確定する
  def create # PreOrderに情報を保存
    # 渡ってきた値を @pre_order に入れる
    @pre_order = current_customer.pre_orders.new(pre_order_params)
    @pre_order.customer_id = current_customer.id
    @pre_order.save
    
      @cart_items = current_customer.cart_items
      @cart_items.each do |cart_item|
        @pre_order_detail = PreOrderDetail.new
        @pre_order_detail.tax_price = cart_item.item.with_tax_price
        @pre_order_detail.quantity = cart_item.quantity
        @pre_order_detail.item_id = cart_item.item_id
        @pre_order_detail.pre_order_id =  @pre_order.id
        @pre_order_detail.save # カート情報を削除するので item との紐付けが切れる前に保存する
      end

    @cart_items.destroy_all # 会員に関連するカートのデータ(予約注文したデータ)をすべて削除(カートを空にする)
    redirect_to over_pre_orders_path 

  end

  def index
    @pre_orders = current_customer.pre_orders.page(params[:page])
  end
  
  def show
    @pre_order = PreOrder.find(params[:id])
    @pre_order_details = @pre_order.pre_order_details.all
  end

  private

  def pre_order_params
    params.require(:pre_order).permit(:total_payment,:receiving_date, :receiving_time, :demand)
  end

end
