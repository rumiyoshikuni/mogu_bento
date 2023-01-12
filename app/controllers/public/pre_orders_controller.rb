class Public::PreOrdersController < ApplicationController
  
  before_action :authenticate_customer!
  
  #予約注文情報の入力画面で受取日、受取時間の選択、要望を入力できる
  def new
    @pre_orders = PreOrder.new
  end
  
  # 予約注文情報確認画面
  def check
    @pre_order = PreOrder.new(pre_order_params)
    # new 画面から渡ってきたデータを @pre_order に入れる
  
  def over
  end
  
  # 予約を確定する
  def create # PreOrderに情報を保存
    # ログインユーザーのカートアイテムをすべて取り出して cart_items に入れる
    @cart_items = current_customer.cart_items.all
    # 渡ってきた値を @pre_order に入れる
    @pre_order = current_customer.pre_orders.new(pre_order_params)
    if @order.save
    cart_items.each do |cart|
      pre_order_item = PreOrderItem.new
      pre_order_item.item_id = cart.item_id
      pre_order_item.order_id = @order.id
      pre_order_item.order_quantity = cart.quantity
    # 予約が完了したらカート情報は削除するのでここに保存
      pre_order_item.pre_order_price = cart.item.price
    # カート情報を削除するので item との紐付けが切れる前に保存します
      pre_order_item.save
    end
    redirect_to pre_orders_path
    # 会員に関連するカートのデータ(予約注文したデータ)をすべて削除(カートを空にする)
    cart_items.destroy_all
  else
    @pre_order = PreOrder.new(pre_order_params)
    render :new
  end
end

  end
  
  def index
  
  end
  
  
  def pre_order_params
    params.require(:pre_order).permit(:customer_id, :total_payment, :is_active, :quantity, :item_id)
  end
  
end
