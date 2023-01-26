class Public::CartItemsController < ApplicationController

  before_action :authenticate_customer!
  before_action :ensure_guest_customer
  # カート内メニュー一覧(数量変更・カート削除の要素を含む)
  def index
    @cart_items = current_customer.cart_items.all
  end
  # カート内メニュー追加
  def create
    @cart_item = current_customer.cart_items.build(cart_item_params)
    @cart_items = current_customer.cart_items.all
    @cart_items.each do |cart_item|
      if cart_item.item_id == @cart_item.item_id
        new_quantity = cart_item.quantity + @cart_item.quantity
        cart_item.update_attribute(:quantity, new_quantity)
        @cart_item.delete
      end
    end
    @cart_item.save
    flash[:notice] = "メニューを追加しました。"
    redirect_to cart_items_path
  end
  # カート内メニュー更新
  def update
    cart_item = CartItem.find(params[:id])
    if cart_item.update(cart_item_params)
      flash[:notice] = "メニューの数量を変更しました。"
      redirect_to cart_items_path
    else
      render 'index'
    end
  end
  # カート内メニュー一つ削除
  def destroy
    cart_item = CartItem.find(params[:id])
    cart_item.destroy
    @cart_items = CartItem.all
    flash[:notice] = "メニューを削除しました。"
    redirect_to cart_items_path
  end
  # カート内メニュー全て削除
  def all_destroy
    current_customer.cart_items.destroy_all
    flash[:notice] = "カートのメニューを全て削除しました。"
    redirect_to cart_items_path
  end

private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :price, :quantity)
  end

  def ensure_guest_customer
    if current_customer.email == "guest@example.com"
      redirect_to root_path, notice: 'ゲストユーザーはカート画面へ遷移できません。'
    end
  end

end