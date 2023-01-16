class Admin::PreOrderDetailsController < ApplicationController
  
  def update
    pre_order_detail = PreOrderDetail.find(params[:id])
    pre_order_detail.update(pre_order_detail_params)
  end

  private
  def pre_order_detail_params
    params.require(:pre_order_detail).permit(:is_maked)
  end
  
end
