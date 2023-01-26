class Admin::PreOrderDetailsController < ApplicationController
  
  before_action :authenticate_admin!
  # 製作ステータスの更新
  def update
    pre_order_detail = PreOrderDetail.find(params[:id])
    if pre_order_detail.update(pre_order_detail_params)
      redirect_to admin_pre_order_path(pre_order_detail.pre_order_id), notice: "製作ステータスが更新されました。"
    end
  end

  private
  def pre_order_detail_params
    params.require(:pre_order_detail).permit(:is_maked)
  end
  
end
