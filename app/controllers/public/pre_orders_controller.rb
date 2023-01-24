class Public::PreOrdersController < ApplicationController

  before_action :authenticate_customer!
  before_action :ensure_guest_customer
  #予約注文情報入力(受取日、受取時間の選択、要望記入)
  def new
    @pre_order = PreOrder.new
  end

  # 予約注文情報確認
  def check
    # new 画面から渡ってきたデータを @pre_order に入れる
    @pre_order = PreOrder.new(pre_order_params)
    @receiving_date = params[:pre_order][:receiving_date]
    @cart_items = current_customer.cart_items.all
    @pre_order.total_payment = @total_payment
    @total_payment = @cart_items.inject(0) { |sum, item| sum + item.subtotal }
    @pre_order_new = PreOrder.new
    # "01月16日(月) => Date.parse("2023-01-16")
    @pre_order.receiving_date = Date.parse("#{Date.today.year}-#{params[:pre_order][:receiving_date].split('日')[0].gsub!(/[^\d]/, '-')}")
    @pre_order.customer_id = current_customer.id
    unless @pre_order.valid?
      render :new
    end
  end

  def over
  end

  # 予約注文確定処理
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
        @pre_order_detail.save # カート情報を削除するので item との紐付けが切れる前に保存する
      end

    @cart_items.destroy_all # 会員に関連するカートのデータ(予約注文したデータ)をすべて削除(カートを空にする)
    redirect_to over_pre_orders_path
  end
  # 予約注文履歴
  def index
    @pre_orders = current_customer.pre_orders.page(params[:page]).per(10)
  end
  # 予約注文履歴詳細
  def show
    # checkでリロードされた場合
    if params[:id] == "check"
      flash[:notice] = "リロードされた為入力画面に戻りました。"
      redirect_to new_pre_order_path
      return
    end
    @pre_order = PreOrder.find(params[:id])
    @pre_order_detail = PreOrderDetail.find(params[:id])
    @pre_order_details = @pre_order.pre_order_details.all
  end
  # 予約注文キャンセル
  def destroy
    @pre_order = PreOrder.find(params[:id])
    if @pre_order.destroy
      flash[:notice] = "予約注文をキャンセルしました。"
      redirect_to pre_orders_path
    else
      render :index
    end
  end

  private

  def pre_order_params
    params.require(:pre_order).permit(:customer_id, :total_payment, :receiving_date, :receiving_time, :demand, :quantity, :item_id)
  end

  def ensure_guest_customer
    if current_customer.email == "guest@example.com"
      redirect_to root_path, notice: 'ゲストユーザーは予約注文情報入力画面へ遷移できません。'
    end
  end

end
