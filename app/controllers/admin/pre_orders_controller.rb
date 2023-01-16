class Admin::PreOrdersController < ApplicationController

  # before_action :authenticate_admin!

  def show
    @pre_order_details = PreOrderDetail.where(pre_order_id: params[:id])
    @pre_order = PreOrder.find(params[:id])
    @total_payment = calculate(@pre_order)
  end

  def calculate(total_payment)
    @total_paymen = 0
    @pre_order_details.each {|pre_order_detail|
    subtotal = pre_order_detail.tax_price * pre_order_detail.quantity
    @total_paymen += subtotal
    }
    return @total_paymen
  end

  def update
    pre_order_details = PreOrderDetail.where(pre_order_id: params[:id])
    pre_order = PreOrder.find(params[:id])
    pre_order.update(pre_order_params)
  end

  private
  def pre_order_params
    params.require(:pre_order).permit(:is_maked)
  end

end