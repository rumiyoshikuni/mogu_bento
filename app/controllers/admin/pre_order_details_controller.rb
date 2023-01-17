class Admin::PreOrderDetailsController < ApplicationController
  
  def update
    pre_order_detail = PreOrderDetail.find(params[:id])
    if pre_order_detail.update(pre_order_detail_params)
      redirect_to admin_pre_order_path(pre_order_detail.pre_order_id)
    end
  end

  private
  def pre_order_detail_params
    params.require(:pre_order_detail).permit(:is_maked)
  end
  
end
