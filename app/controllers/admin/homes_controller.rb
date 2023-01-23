class Admin::HomesController < ApplicationController
  
  before_action :authenticate_admin!
  # 管理者トップページ(予約注文履歴一覧)
  def top
    @pre_orders = PreOrder.page(params[:page]).per(10)
  end
  
end
