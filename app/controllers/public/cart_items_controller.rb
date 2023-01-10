class Public::CartItemsController < ApplicationController

  before_action :authenticate_customer!

  def index
    @cart_items = current_customer.cart_items.all
  end

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
    redirect_to cart_items_path
  end

  def update
    cart_item = CartItem.find(params[:id])
    if cart_item.update(cart_item_params)
    redirect_to cart_items_path
  # カートアイテムの更新に成功した時の処理
    else
      render 'index'
  # 失敗した時の処理
    end
  end

  def destroy
    cart_item = CartItem.find(params[:id])
    cart_item.destroy
    @cart_items = CartItem.all
    redirect_to cart_items_path
  end

  def all_destroy  #カート内全て削除
    current_customer.cart_items.destroy_all
    redirect_to cart_items_path
  end

private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :price, :quantity)
  end
  
end